clear; clc; close all;

%% Define constants
baseMass        = 1.0;     % Base mass without arms or payload (kg)
baseDroneCost   = 50.00;   % Assumed base drone component cost (USD)
numArms         = 4;       % Number of quadcopter arms
gravity         = 9.81;    % Acceleration due to gravity (m/s^2)
thrustPerMotor  = 9.81;    % Thrust per motor in Newtons (1 kgf = 9.81 N)
totalThrust     = 39.24;   % Total quadcopter thrust (4 motors = 39.24 N)
targetTWR       = 2.0;     % Target Thrust-to-Weight Ratio
csvFile         = 'Materials.csv';
stlFile         = 'CircleArm.STL';
% stlFile       = 'TriangleArm.STL';

% Model Face IDs (Check pdegplot to verify face numbers for your geometry)
motorFaces      = 10; % Motor mounting screw faces or the middle hole (Zeke said the difference is negligible on solidworks)
fixedFace       = 5;             % Body mounting bolt hole face

%% Open STL file and compute geometry volume
% Read STL Mesh
stlData = stlread(stlFile);

% Compute volume using tetrahedron signed volumes method
v1 = stlData.Points(stlData.ConnectivityList(:,1), :);
v2 = stlData.Points(stlData.ConnectivityList(:,2), :);
v3 = stlData.Points(stlData.ConnectivityList(:,3), :);
rawVolume = sum(dot(v1, cross(v2, v3, 2), 2)) / 6;
rawVolume = abs(rawVolume);

% Auto-convert units (mm^3 vs m^3)
if rawVolume > 1.0
    volume_mm3 = rawVolume;
    volume_m3  = rawVolume * 1e-9;
else
    volume_m3  = rawVolume;
    volume_mm3 = rawVolume * 1e9;
end


fprintf('Single Arm Volume: %.4f mm³ (%.6e m³)\n', volume_mm3, volume_m3);

% Max mass capacity for target 2:1 TWR (2.0 kg)
maxTotalMass = totalThrust / (targetTWR * gravity);

%% Open CSV file
opts = detectImportOptions(csvFile);
opts.VariableNamingRule = 'preserve';
df = readtable(csvFile, opts);

% Identify column indices flexibly
colNames = df.Properties.VariableNames;
nameColIdx    = find(contains(lower(colNames), 'name'), 1);
densityColIdx = find(contains(lower(colNames), 'density'), 1);
costColIdx    = find(contains(lower(colNames), 'cost'), 1);
EColIdx       = find(contains(lower(colNames), 'e_pa') | contains(lower(colNames), 'young'), 1);
nuColIdx      = find(contains(lower(colNames), 'nu') | contains(lower(colNames), 'poisson'), 1);
yieldColIdx   = find(contains(lower(colNames), 'yield'), 1);
numMaterials  = height(df);

%% Initialize PDE model and mesh (OUTSIDE LOOP)

%fprintf('Building Finite Element Mesh and setting up boundary conditions...\n');
%model = createpde("structural", "static-solid");
%nodes = stlData.Points';
%elements = stlData.ConnectivityList';
%geometryFromMesh(model, nodes, elements);

% Generate mesh ONCE to ensure consistent node topology across materials
%generateMesh(model, 'Hmax', 0.002);

% Calculate combined surface area of motor mounting faces
%for f = motorFaces
%    totalArea = totalArea + faceArea(model.Geometry, f);
%end

% Surface traction pressure in Pascals (N/m^2)
%tractionValue = thrustPerMotor / totalArea;

% Apply Loads and Fixed Support Boundary Conditions
%structuralBoundaryLoad(model, 'Face', motorFaces, 'SurfaceTraction', [0; 0; tractionValue]);
%structuralBC(model, 'Face', fixedFace, 'Constraint', 'fixed');

%% Initialize PDE model and mesh (OUTSIDE LOOP)
fprintf('Building Finite Element Mesh and setting up boundary conditions...\n');
model = createpde("structural", "static-solid");
nodes = stlData.Points';
elements = stlData.ConnectivityList';
geometryFromMesh(model, nodes, elements);

% Generate mesh ONCE to ensure consistent node topology across materials
generateMesh(model, 'Hmax', 0.002);

% --- VISUALIZATION: DISPLAY GEOMETRY FACE NUMBERS & MESH ---
figure('Name', 'STL Geometry Face Labels', 'Color', 'w');
pdegplot(model, 'FaceLabels', 'on', 'FaceAlpha', 0.5);
title('Geometry Face Numbers (Rotate to inspect faces)');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');
grid on;

figure('Name', 'Finite Element Mesh', 'Color', 'w');
pdeplot3D(model);
title('Generated 3D Finite Element Mesh');
xlabel('X (m)'); ylabel('Y (m)'); zlabel('Z (m)');

% Calculate combined surface area of motor mounting faces
totalArea = 0;
for f = motorFaces
    totalArea = totalArea + faceArea(model.Geometry, f);
end

% Surface traction pressure in Pascals (N/m^2)
tractionValue = thrustPerMotor / totalArea;

% Apply Loads and Fixed Support Boundary Conditions
structuralBoundaryLoad(model, 'Face', motorFaces, 'SurfaceTraction', [0; 0; tractionValue]);
structuralBC(model, 'Face', fixedFace, 'Constraint', 'fixed');

%% FEA for all material
% Pre-allocate results structure
results = struct('Material', {}, 'SingleArmMass_g', {}, 'TotalArmMass_g', {}, ...
                 'EmptyMass_kg', {}, 'MaxPayload_kg', {}, 'TotalArmCost_USD', {}, ...
                 'TotalCost_USD', {}, 'MaxStress_MPa', {}, 'MaxDisp_mm', {}, ...
                 'FoS', {}, 'Status', {});

fprintf('                   Summary Table                   \n');
fprintf('========================================================================================\n');

for i = 1:numMaterials
    % Extract Material Properties from Table Row
    matName      = string(df{i, nameColIdx});
    density      = df{i, densityColIdx};   % kg/m^3
    costPerKg    = df{i, costColIdx};      % USD/kg (or USD/m^3 if using volume directly)
    E_val        = df{i, EColIdx};         % Young's Modulus (Pa)
    nu_val       = df{i, nuColIdx};        % Poisson's Ratio
    yieldStr_val = df{i, yieldColIdx};     % Yield Strength (Pa)
    
    % --- Mass & Cost Calculations (4 Arms) ---
    singleArmMass = density * volume_m3;
    totalArmMass  = singleArmMass * numArms;
    emptyMass     = baseMass + totalArmMass;
    payloadCap    = maxTotalMass - emptyMass;
    
    singleArmCost = costPerKg * singleArmMass;
    totalArmCost  = singleArmCost * numArms;
    totalCost     = baseDroneCost + totalArmCost;

    % --- Update Material Properties & Solve FEA ---
    structuralProperties(model, 'Cell', 1, 'YoungsModulus', E_val, 'PoissonsRatio', nu_val);
    
    result = solve(model);
    
    % --- Extract FEA Performance Metrics ---
    maxStress = max(result.VonMisesStress);
    dispMag   = sqrt(result.Displacement.ux.^2 + result.Displacement.uy.^2 + result.Displacement.uz.^2);
    maxDisp   = max(dispMag);
    FoS       = yieldStr_val / maxStress;
    
    if FoS >= 1.0
        statusStr = 'PASS';
    else
        statusStr = 'FAIL';
    end
    
    % Store Results
    results(i).Material          = matName;
    results(i).SingleArmMass_g   = round(singleArmMass * 1000, 2);
    results(i).TotalArmMass_g    = round(totalArmMass * 1000, 2);
    results(i).EmptyMass_kg      = round(emptyMass, 4);
    results(i).MaxPayload_kg     = round(payloadCap, 4);
    results(i).TotalArmCost_USD  = round(totalArmCost, 2);
    results(i).TotalCost_USD     = round(totalCost, 2);
    results(i).MaxStress_MPa     = round(maxStress / 1e6, 2);
    results(i).MaxDisp_mm        = round(maxDisp * 1000, 4);
    results(i).FoS               = round(FoS, 2);
    results(i).Status            = statusStr;
end


%% Show final summary table
%  =========================================================================
summaryTable = struct2table(results);
disp(summaryTable);

