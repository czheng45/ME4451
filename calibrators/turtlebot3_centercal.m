function [centercoord] = turtlebot3_center(cam)
%Get the turning center of the turtlebot, which is the big blue circle

im = snapshot(cam);
im = filterRobotSnapshot(im);

bodies = getCalibrationSpots(im,@calibratorMaskBlue);
spotsizes = [bodies.Area];
idx = find(spotsizes == max(spotsizes));

centercoord = round(bodies(idx).Centroid);
centercoord = centercoord(end:-1:1);

end

