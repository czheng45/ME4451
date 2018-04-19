function [adjim] = filterRobotSnapshot(image)
%----------------------------filterRobotSnapshot-------------------------------
%DESCRIPTION
%   Filters an overhead image of the turtlebot3, enhancing the calibration
%	spots and darkening/dulling the background for better calspot detection
%
%INPUT ARGUMENTS
%   image:
%       raw image containing the turtlebot's calibration spots.
%
%
%   Example call: filterim = filterRobotSnapshot(roboimage)
%
%OUTPUT ARGUMENTS
%   adjim:
%       RGB adjusted image.
%
%FUNCTION CALLS 
%   wiener3
%	imadjust
%
%------------------------------------------------------------------------------

adjim = image - getBGDmap(image);
adjim = imadjust(adjim,[0.4,0.4,0.4;1,1,1]);

end

