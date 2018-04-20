function [ratio] = lengthRatio(calspots)
%---------------------------------lengthRatio----------------------------------
%DESCRIPTION
%   Returns a conversion factor of cm/pix, converting pixels to real-world
%	units. Uses the passed in calibration spots to scale the distance
%   between calibration spots in pixels to centimeters based on the
%   standard spot separation of 9cm.
%
%INPUT ARGUMENTS
%	calspots:
%		An array of 2 body structs. Each MUST contain the CENTROID
%       field. The calibration uses the centers to calculate a pixel
%       distance which is converted to cm. If there are more than 2
%       calspots passed in, ratio will be NaN.
%
%OUTPUT ARGUMENTS
%   ratio:
%       double conversion factor: units of cm/pix
%
%FUNCTION CALLS 
%
%------------------------------------------------------------------------------

ratio = NaN;
if length(calspots) ~= 2
    return;
end

cald = 9; %cm
r = calspots(1).Centroid - calspots(2).Centroid;
pixd = (r(1)^2 + r(2)^2)^0.5; %get abs distance between them in pixels
ratio = 9/pixd; %cm per pixel


end

