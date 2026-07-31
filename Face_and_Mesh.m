clear; clc; close all;

% Create a static structural model container
model = createpde("structural", "static-solid");

% Import STL file
importGeometry(model, "CircleArm.STL");
%importGeometry(model, "TriangleArm.STL");

% Plot the geometry with Face Labels
figure;
pdegplot(model, FaceLabels="on", FaceAlpha=0.5);
title('Geometry with Face Labels');

% Generate and visualize the mesh
generateMesh(model);
figure;
pdeplot3D(model);
title('Mesh Plot');