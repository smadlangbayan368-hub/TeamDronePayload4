%% Drone Arm Material Selection
% MAE Project - Step 3
% Performs a thrust-to-weight analysis for every material option.

clear;
clc;
close all;

%% -----------------------------
% Load Material Database
%% -----------------------------
load('droneArmMaterials.mat');

%% -----------------------------
% Import CAD Geometry
%% -----------------------------
model = createpde('structural','static-solid');

importGeometry(model,'LatticeDroneArmV1.STEP');

figure;
pdegplot(model,'FaceLabels','on','FaceAlpha',0.5);
title('Drone Arm Geometry with Face Labels');
axis equal

%% -----------------------------
% Design Parameters
%% -----------------------------

numArms = 4;

componentMass = 1.0;      % kg (everything except arms & payload)

numMotors = 4;
maxThrustPerMotor = 1.0;  % kg thrust per motor

totalThrust = numMotors * maxThrustPerMotor;

requiredTWR = 2.0;

minimumPayload = 0.5;     % kg

%% -----------------------------
% Arm Volume
%% -----------------------------
% Replace this value with the volume from:
% SolidWorks -> Evaluate -> Mass Properties
% Units must be cubic meters (m^3)

armVolume =  10.419449e-5;      % volume given in SolidWorks

%% -----------------------------
% Analyze Every Material
%% -----------------------------

fprintf('\n');
fprintf('=====================================================================================\n');
fprintf('| %-32s | %8s | %8s | %6s | %6s |\n', ...
    'Material','Arm Mass','Payload','TWR','Status');
fprintf('=====================================================================================\n');

bestPayload = -inf;
bestMaterial = "";

for i = 1:length(materials)

    [armMass,totalMass,payload,TWR,passes] = step3MaterialsAnalysisFunction(...
        materials(i),...
        armVolume,...
        componentMass,...
        numArms,...
        totalThrust,...
        requiredTWR,...
        minimumPayload);

    if passes
        status = "PASS";
    else
        status = "FAIL";
    end

    fprintf('| %-32s | %8.3f | %8.3f | %6.2f | %6s |\n', ...
        materials(i).name,...
        armMass,...
        payload,...
        TWR,...
        status);

    if passes && payload > bestPayload
        bestPayload = payload;
        bestMaterial = materials(i).name;
    end

end

fprintf('=====================================================================================\n');

%% -----------------------------
% Best Material
%% -----------------------------

fprintf('\n');

if bestPayload > 0

    fprintf('Best Material    : %s\n', bestMaterial);
    fprintf('Maximum Payload  : %.3f kg\n', bestPayload);

else

    fprintf('No material satisfies the project requirements.\n');

end

%% ============================================================
%% STEP 4: Finite Element Analysis (FEA)
%% ============================================================
% FEA is run on the single imported arm geometry ("model") for every
% material to evaluate max displacement, max Von Mises stress, and
% factor of safety (FOS = yield strength / max stress).
%
% Two loads act on the motor-mount face:
%   1) Upward thrust force  (motor pushing up on the arm)
%   2) Downward motor weight force (motor's own weight)
% Because both act along the same axis at the same location, they are
% combined into a single net surface traction for the solver -- this
% is physically equivalent to applying them as two separate loads.
% The root face (where the arm bolts to the drone body) is fixed.

%% ---- Face IDs ----
% Look at the figure from pdegplot(model,'FaceLabels','on') above,
% rotate/zoom it, and read off the face numbers for:
rootFaceID  = 23;   % <-- fixed support
motorFaceID = 24;   % <-- Loads applied

%% ---- Load Assumptions ----
motorMass = 0.075;               % kg  motor mass + propeller mass
g = 9.81;                         % m/s^2

thrustForce      = maxThrustPerMotor * g;          % N, upward (+y)
motorWeightForce = motorMass * g;                  % N, downward (-y)
netForce         = thrustForce - motorWeightForce; % N, net along +y

% Area of the motor-mount face (SolidWorks -> Evaluate -> Area, in m^2)
motorFaceArea = 0.0004548348;   % m^2  <-- REPLACE with the actual face area from CAD

netTraction = netForce / motorFaceArea;   % Pa (N/m^2), applied along +y

%% ---- Boundary Conditions & Loads (same for every material) ----
structuralBC(model,'Face',rootFaceID,'Constraint','fixed');

structuralBoundaryLoad(model,'Face',motorFaceID, ...
    'SurfaceTraction',[0;netTraction;0]);
%% ---- Mesh (generated once, reused for every material) ----
generateMesh(model,'Hmax',0.003);   % <-- adjust Hmax to refine/coarsen the mesh

%% ---- Loop Over Materials ----
fprintf('\n');
fprintf('=====================================================================================\n');
fprintf('| %-32s | %10s | %13s | %8s | %6s |\n', ...
    'Material','MaxDisp(mm)','MaxStress(MPa)','FOS','Status');
fprintf('=====================================================================================\n');

feaResults = struct('name',{},'maxDisp',{},'maxStress',{},'FOS',{});

for i = 1:length(materials)

    mat = materials(i);

    % NOTE: verify these field names match your droneArmMaterials.mat
    % (run "materials(1)" in the Command Window to check). Update if
    % your struct uses different names, e.g. E, nu, sigma_y_Pa, etc.
    structuralProperties(model, ...
        'YoungsModulus',mat.E_Pa, ...
        'PoissonsRatio',mat.nu);

    result = solve(model);

    dispMag   = sqrt(result.Displacement.ux.^2 + ...
                      result.Displacement.uy.^2 + ...
                      result.Displacement.uz.^2);
    maxDisp   = max(dispMag);                  % m
    maxStress = max(result.VonMisesStress);     % Pa
    FOS       = mat.yieldStrength_Pa / maxStress;

    feaResults(i).name      = mat.name;
    feaResults(i).maxDisp   = maxDisp;
    feaResults(i).maxStress = maxStress;
    feaResults(i).FOS       = FOS;

    if FOS >= 1
        status = "PASS";
    else
        status = "FAIL";
    end

    fprintf('| %-32s | %10.4f | %13.2f | %8.2f | %6s |\n', ...
        mat.name, maxDisp*1000, maxStress/1e6, FOS, status);

    %% Visualization: x-, y-, z-displacement and Von Mises stress
    figure('Name',sprintf('FEA Results - %s',mat.name), ...
           'Position',[100 100 1200 800]);

    subplot(2,2,1);
    pdeplot3D(model,'ColorMapData',result.Displacement.ux);
    title(sprintf('%s: X-Displacement (m)',mat.name));

    subplot(2,2,2);
    pdeplot3D(model,'ColorMapData',result.Displacement.uy);
    title(sprintf('%s: Y-Displacement (m)',mat.name));

    subplot(2,2,3);
    pdeplot3D(model,'ColorMapData',result.Displacement.uz);
    title(sprintf('%s: Z-Displacement (m)',mat.name));

    subplot(2,2,4);
    pdeplot3D(model,'ColorMapData',result.VonMisesStress);
    title(sprintf('%s: Von Mises Stress (Pa)',mat.name));

end

fprintf('=====================================================================================\n');

%% ---- Material with the Highest Factor of Safety ----
[~,bestFOSIdx] = max([feaResults.FOS]);
fprintf('\n');
fprintf('Highest Factor of Safety : %s (FOS = %.2f)\n', ...
    feaResults(bestFOSIdx).name, feaResults(bestFOSIdx).FOS);