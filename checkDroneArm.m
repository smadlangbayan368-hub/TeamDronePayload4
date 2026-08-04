function[] = checkDroneArm(stlFile)
load droneArmMaterials.mat

mass = zeros(6,1);
cost = zeros(6,1);
max_payload = zeros(6,1);
max_stress = zeros(6,1);
max_displacement = zeros(6,1);
SF = zeros(6,1);

gm = createpde;
importGeometry(gm, stlFile);
gm.Geometry = scale(gm.Geometry,0.001);
mesh = generateMesh(gm);
vol = volume(mesh);
for i = 1:6
    mass(i,1) = vol * materials(i).rho_kg_m3;
    cost(i,1) = vol * (materials(i).cost_USD_per_m)^3;
    name(i,1) = materials(i).name;
    max_payload(i,1) = 1 - (4*mass(i,1));   
end

figure
md = femodel(AnalysisType="structuralStatic",Geometry=gm.Geometry);
pdegplot(md.Geometry,FaceLabels="on",FaceAlpha=0.3);
md = generateMesh(md,Hmin=.0005,Hmax=1);

fprintf('\nInput number of fixed faces');
j = input(': ');
for i = 1:j
    fprintf('\nInput fixed face #%d',i);
    fixpoints(1,i) = input(': ');
end
md.FaceBC(fixpoints) = faceBC(Constraint="fixed");

fprintf('\nInput hole face for load');
loadface = input(': ');
fprintf('\nInput load hole radius in millimeters');
lfr = input(': ');
fprintf('\nInput load hole depth in millimeters');
lfd = input(': ');
fprintf('\n');
surfaceload = (9.07425) / (2 * pi * lfr * lfd * 1e-6);
figure
md.FaceLoad(loadface) = faceLoad(SurfaceTraction=[0 0 surfaceload]);
md.CellLoad(1) = cellLoad(Gravity=[0 0 -9.81]);
for i = 1:6
    md.MaterialProperties = materialProperties(...
        YoungsModulus=materials(i).E_Pa, ...
        PoissonsRatio=materials(i).nu, ...
        MassDensity=materials(i).rho_kg_m3);
    sol = solve(md);
    max_stress(i,1) = max(sol.VonMisesStress);
    max_displacement(i,1) = max(sol.Displacement.Magnitude);
    if max_stress(i,1) < materials(i).yieldStrength_Pa
        SF(i,1) = materials(i).yieldStrength_Pa/max_stress(i,1);
    end

    subplot(2,3,i);
    meshData = sol.Mesh;
    nodalData = sol.VonMisesStress;
    deformationData = sol.Displacement;

    resultViz = pdeviz(meshData,nodalData, ...
        "DeformationData",deformationData, ...
        "DeformationScaleFactor",1, ...
        "Title",materials(i).name, ...
        "ColorLimits",[6.495e-09 5772000]);

    clearvars meshData nodalData deformationData

end

t = table(name,mass,cost,max_payload,max_stress,SF, max_displacement);
disp(t);

end