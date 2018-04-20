%Directory


[pic] = takepic(1);

[start] = findstart(pic);

[stop] = findstop(pic);

[adjim] = filterRobotSnapshot(pic);

[blueangle] = findangle(getCalibrationSpots(adjim,@calibratorMaskBlue));

[expandedbinary,goodmap] = findMap(pic, .2); %Should be .1
figure
imshow(expandedbinary);