function [avgl] = turtlebot3_lengthCal2(cam,velpub,velmsg,varargin)
%----------------------------turtlebot3_lengthCal2-----------------------------
%DESCRIPTION
%   Returns a conversion factor of cm/pix, converting pixels to real-world
%	units. Uses Pink and Blue spots together for redundancy, and throws
%   warnings if the image is too skewed or too many NaNs occur when
%   getting the ratios from a single calspot pair.
%
%   Additionally, if run in 'full' mode, repeats this procedure as the
%   robot spins in a full circle for extra redundancy and accuracy checking
%
%INPUT ARGUMENTS
%   cam:
%       webcam used to capture robot images
%   velpub:
%       turtlebot3's velocity publisher
%   velmsg:
%       the format of the message to be sent using velpub
%   varargin:
%       Choose the mode of operation.
%       [] - single mode. Does not spin the robot. Only takes the ratio
%            using the Blue and then Pink calspots once. Fast, but
%            takes the least data and thus least accurate/safe.
%
%   'full' - full mode. Does a 360 degree spin of the robot. Stops and
%            takes an image every 60 degrees, and calculates the conversion
%            factor using Blue and Pink, for 12 total. More accurate.

%OUTPUT ARGUMENTS
%   avgl:
%       averaged double conversion factor: units of cm/pix
%
%FUNCTION CALLS 
%   filterRobotSnapshot
%   lengthRatio
%   robotRotate
%------------------------------------------------------------------------------
opts.mode = 1;
if length(varargin) > 0
   if strcmp(varargin{1},'full')
      opts.mode = 6; 
   end
end

thetad = mod(360/opts.mode, 360); %change in angle for every new pose

ratios = zeros([2,opts.mode]);

for i = 1:opts.mode %Repeat this procedure over a number of different orientations
    
    rawim = snapshot(cam); %view current bot position
    filterim = filterRobotSnapshot(rawim); %filter calibration spots

    bodies = getCalibrationSpots(filterim,@calibratorMaskBlue); %get blue
    ratios(1,i) = lengthRatio(bodies); %Store Blue's ratio
    
    bodies = getCalibrationSpots(filterim,@calibratorMaskPink); %get pink
    ratios(2,i) = lengthRatio(bodies); %Store Pink's ratio
    
    %robot rotate by thetad
end

ratios = ratios(:)';
%{
if sum(isnan(ratios)) > floor(length(ratios)/3)
   warning('There are too many poor-quality extractions');
end
%}

avgl = nanmean(ratios);
diffs = abs((ratios./avgl) - 1);
if any(diffs > 0.02)
   warning('The ratios of all your calibration lengths are too far apart. Is the camera at a poor angle?'); 
end

end

