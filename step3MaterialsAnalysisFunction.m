function [armMass,totalMass,payload,TWR,passes] = step3MaterialsAnalysisFunction(...
    material,...
    armVolume,...
    componentMass,...
    numArms,...
    totalThrust,...
    requiredTWR,...
    minimumPayload)

% Material density
density = material.rho_kg_m3;

% Mass of one arm
armMass = density * armVolume;

% Mass of all four arms
totalArmMass = numArms * armMass;

% Drone mass without payload
droneMass = componentMass + totalArmMass;

% Maximum payload allowed while maintaining TWR
payload = totalThrust/requiredTWR - droneMass;

% Total mass including payload
totalMass = droneMass + payload;

% Actual thrust-to-weight ratio
TWR = totalThrust / totalMass;

% Check project requirements
passes = (payload >= minimumPayload) && (TWR >= requiredTWR);

end