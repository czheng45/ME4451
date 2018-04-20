function [expandedbinary,goodmap] = findMap(pic, lengthcalibrationfactor)

safety = 1.25;
robotbound = 21.0;
%find robot's blue dot
% [adjim] = filterRobotSnapshot(pic);
% [calspots] = getCalibrationSpots(adjim,@calibratorMaskBlue);
% bigbluelocation = calspots(1).Centroid;
%get length calibration

%find boundaries
[goodmap, maskedRGBImage] = findboundaries(pic);
%Expand by length of robot



%Everything around robot is deleted %166mm 0.1cm/px
%find orange dot
[adjim] = filterRobotSnapshot(pic);

[BW,justorange] = calibratorMaskOrange(adjim);
[calspots] = getCalibrationSpots(adjim,@calibratorMaskOrange);
orangelocation = calspots(1).Centroid;
x = round(orangelocation(1));
y = round(orangelocation(2));
%imshow(goodmap)
%make everything around it zeros
for i = x-50:x+50
    for j = y-50:y+50
        goodmap(j,i) = 0;
    end
end
[expandedbinary] = boundExpand(goodmap,safety*robotbound/2/lengthcalibrationfactor);
%imshow(goodmap)

%imshow(expandedbinary)
end
