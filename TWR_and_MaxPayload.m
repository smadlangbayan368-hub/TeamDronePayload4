clear; clc; close all;

%% Constants
baseMass      = 1.0;                  % Base mass without arms or payload (kg)
baseDroneCost = 50.00;                % Assumption base drone component cost (USD)
numArms       = 4;                    % Number of drone arms
gravity       = 9.81;                 % Acceleration due to gravity (m/s^2)
thrust        = 39.24;                % Total thrust in Newtons (1 kg of thrust = 9.81 N) * 4 motors
targetTWR     = 2.0;                  % Target Thrust-to-Weight Ratio
csvFile       = 'Materials.csv';       % Materials file (cost units: USD/kg)
%stlFile       = 'TriangleArm.STL';   % Courtesy of Zeke
stlFile       = 'CircleArm.STL';

%% Extract the volume from the STL (value is close enough)
% Check if the file exists in the working directory
if ~exist(stlFile, 'file')
    error('File "%s" was not found in the current folder. Check the filename and try again.', stlFile);
end

fprintf('Loading STL file: %s\n', stlFile);

% Read STL Mesh
meshData = stlread(stlFile);

% Compute volume using tetrahedron signed volumes method
v1 = meshData.Points(meshData.ConnectivityList(:,1), :);
v2 = meshData.Points(meshData.ConnectivityList(:,2), :);
v3 = meshData.Points(meshData.ConnectivityList(:,3), :);

% Signed volume calculation for STL faces
rawVolume = sum(dot(v1, cross(v2, v3, 2), 2)) / 6;
rawVolume = abs(rawVolume);

% Unit Auto-Conversion (mm^3 vs m^3)
if rawVolume > 1.0
    singleArmVolume_mm3 = rawVolume;
    singleArmVolume_m3  = rawVolume * 1e-9;
else
    singleArmVolume_m3  = rawVolume;
    singleArmVolume_mm3 = rawVolume * 1e9;
end

fprintf('Single Arm Volume: %.4f mm³ (%.6e m³)\n', singleArmVolume_mm3, singleArmVolume_m3);

% Maximum allowable total mass for 2:1 TWR (2.0 kg total mass limit)
maxTotalMass = thrust / (targetTWR * gravity);

%% Read CSV file & calculations
opts = detectImportOptions(csvFile);
opts.VariableNamingRule = 'preserve';
df = readtable(csvFile, opts);

% Find relevant columns flexibly
colNames = df.Properties.VariableNames;
nameColIdx    = find(contains(lower(colNames), 'name'), 1);
densityColIdx = find(contains(lower(colNames), 'density'), 1);
costColIdx    = find(contains(lower(colNames), 'cost'), 1);

numMaterials = height(df);

% Preallocate vectors for performance
Material                = df{:, nameColIdx};
Single_Arm_Mass_kg      = zeros(numMaterials, 1);
Total_Arm_Mass_kg       = zeros(numMaterials, 1);
Empty_Mass_kg           = zeros(numMaterials, 1);
TWR_Unloaded            = zeros(numMaterials, 1);
Max_Payload  = zeros(numMaterials, 1);
Total_Arm_Cost_USD      = zeros(numMaterials, 1);
Total_Cost_USD          = zeros(numMaterials, 1);

for i = 1:numMaterials
    density   = df{i, densityColIdx};  % kg/m^3
    costPerKg = df{i, costColIdx};     % USD/kg (changing this to USD/m^3 makes no sense and so is USD/m)
    
    % Mass calculations (4 arms)
    singleArmMass = density * singleArmVolume_m3;
    totalArmMass  = singleArmMass * numArms;
    emptyMass     = baseMass + totalArmMass;
    
    % Performance & Payload calculations
    twrUnloaded     = thrust / (emptyMass * gravity);
    payloadCapacity = maxTotalMass - emptyMass;
    
    % Cost calculations (4 arms)
    singleArmCost = costPerKg * singleArmMass;
    totalArmCost  = singleArmCost * numArms;
    totalCost     = baseDroneCost + totalArmCost;
    
    % Assign rounded values
    Single_Arm_Mass_kg(i)     = round(singleArmMass, 4);
    Total_Arm_Mass_kg(i)      = round(totalArmMass, 4);
    Empty_Mass_kg(i)          = round(emptyMass, 4);
    TWR_Unloaded(i)           = round(twrUnloaded, 3);
    Max_Payload(i)  = round(payloadCapacity, 4);
    Total_Arm_Cost_USD(i)     = round(totalArmCost, 4);
    Total_Cost_USD(i)         = round(totalCost, 4);
end

%% 4. DISPLAY RESULTS TABLE
summaryTable = table(Material, Single_Arm_Mass_kg, Total_Arm_Mass_kg, Empty_Mass_kg, ...
                     TWR_Unloaded, Max_Payload, Total_Arm_Cost_USD, Total_Cost_USD);

disp('========================================================================================');
disp('                                                      DRONE PERFORMANCE & COST ANALYSIS                      ');
disp(summaryTable);
