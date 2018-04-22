function [cmperpix] = turtlebot3_lengthcal(filterim,varargin)
%----------------------------turtlebot3_lengthcal------------------------------
%DESCRIPTION
%   Returns a conversion factor of cm/pix, converting pixels to real-world
%	units. Uses the turtlebot3's calibration spots, which by default
%	are 9cm apart.
%
%
%INPUT ARGUMENTS
%	filterim:
%		filtered image taken from webcam that has a clear view of the
%       turtlebot3. The filter that should be used is filterRobotSnapshot
%
%   varargin:
%       'show' - shows all plots of image masks from each subfunction
%
%   Example call: conversion = turtlebot3_lengthcal(roboim);
%
%OUTPUT ARGUMENTS
%   cmperpix:
%       double conversion factor: units of cm/pix
%
%FUNCTION CALLS 
%   getCalibrationSpots
%	calibratorMaskBlue
%	calibratorMaskPink
%------------------------------------------------------------------------------

actual_distance = 9; %distance between blue calibration circle centers in cm

opts.show = false;
if length(varargin) > 0
    if strcmpi(varargin{1},'show')
        opts.show = true;
    end
end

%pink and blue calibrationspots get
calspots{1} = getCalibrationSpots(filterim,@calibratorMaskBlue,varargin);
calspots{2} = getCalibrationSpots(filterim,@calibratorMaskPink,varargin);

d_sets = zeros([1,length(calspots)]);

for q = 1:length(calspots)
	%ideally, there are only two such objects per calspot set.
	%If there are more or less, then something might be wrong with our mask.
	%Issue a warning.
	if length(calspots{q}) > 2 %too many
	   warning('More than two calibration bodies were detected.');

    elseif length(calspots{q}) < 2 %too few
	   warning('Less than two calibration bodies were detected.');
	   d_sets(q) = NaN;

	else %everything is normal
		r = calspots{q}(1).Centroid - calspots{q}(2).Centroid;
		d_sets(q) = (r(1)^2 + r(2)^2)^0.5; %get abs distance between them in pixels

	end%if
    
end %for

if sum(isnan(d_sets)) > floor(length(d_sets)/3) %too many nans
	cmperpix = NaN;
	return;
end

d_sets(isnan(d_sets)) = []; %remove nans

if any(abs((d_sets./mean(d_sets)) - 1) > 0.025) %calculation from different spots is too different
	warning('Too much variance in distance scalings calculated. Is the image at an angle or improperly oriented?');
	cmperpix = NaN;
	return;
end 

cmperpix = actual_distance/mean(d_sets); %get conversion factor of pixels to cm

end


