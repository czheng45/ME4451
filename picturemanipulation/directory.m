%Directory


[pic] = takepic(1);

[start] = findstart(pic);

[stop] = findstop(pic);

[adjim] = filterRobotSnapshot(pic);
imshow(adjim)

[blueangle] = findangle(getCalibrationSpots(adjim,@calibratorMaskBlue,'show'));

%[pinkangle] = findangle(getCalibrationSpots(adjim,@calibratorMaskPink,'show'));
