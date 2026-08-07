smodel = createpde('structural', 'static-solid');
importGeometry(smodel,'LatticeDroneArmV1.STEP');
pdegplot(smodel,'FaceLabels','on','FaceAlpha', 0.2);
view(3)
