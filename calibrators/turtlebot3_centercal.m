function [centercoord] = turtlebot3_center(im)
%Get the turning center of the turtlebot, which is the big blue circle

bodies = getCalibrationSpots(im,@calibratorMaskBlue);
spotsizes = [bodies.Area];
idx = find(spotsizes == max(spotsizes));

centercoord = round(bodies(idx).Centroid);
centercoord = centercoord(end:-1:1);

end

