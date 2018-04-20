function [calspots] = getCalibrationSpots(filterim,calibrationmask,varargin)
%----------------------------getCalibrationSpots-------------------------------
%DESCRIPTION
%   This function finds and gets the properties of the turtlebot3's custom
%   calibration spots, using an image of the robot and some colormask used for
%   the calibration spots desired (std colors should be blue, hot pink, orange)
%   and returns their Centroid and Area (as in regionprops).
%
%   Attempts to remove any spots that aren't circular or are not large enough
%   to be circles. Warns the user if there are the wrong number of spots
%   detected
%
%INPUT ARGUMENTS
%   im:
%       image containing the turtlebot's calibration spots. should be pre
%       filtered.
%
%   calibrationmask:
%       a function handle containing the colormask by which to mask the
%       color of the calibration spots desired.
%
%   varargin:
%       []     - does nothing
%
%       'show' - shows the binary image of the calibration bodies with their
%                centroids marked.
%
%   Example call: bodies = getCalibrationSpots(roboimage,@calibratorMaskBlue)
%
%OUTPUT ARGUMENTS
%   calspots:
%       a [n x 1] array of structs, each element pertaining to a single
%       detected calibration spot. Each struct contains the Centroid and Area
%       of the detected calibration spot.
%
%FUNCTION CALLS 
%   isCircle
%   sizeCutoff
%   calibrationmask
%   regionprops
%
%------------------------------------------------------------------------------

%parse varargs
opts.show = false;
if length(varargin) > 0
    if strcmpi(varargin{1},'show')
        opts.show = true;
    end
end

%get only the calibrator spots specified by the calibration color mask
%function 'calibrationmask'
[maskimg,~] = calibrationmask(filterim);

%get all bodies that pass through the colormap
calspots = regionprops(maskimg,'MajorAxisLength','MinorAxisLength','Centroid','EquivDiameter','Area');

%gets rid of really small bodies that can't even be counted as circles.
calspots = sizeCutoff(calspots);

%get rid of non-circles
calspots = isCircle(calspots);

if strcmp(func2str(calibrationmask),'calibratorMaskOrange')
    limit = 1;
else
    limit = 2;
end

if length(calspots) > limit
    warning('Too many calibration spots detected');
elseif length(calspots) < limit
    warning('Too few calibration spots detected');
end

if opts.show %optional plot of the obtained calibration spots
    figure
    imshow(maskimg); %double check
    hold on;
    for i = 1:length(calspots) %plot each centroid
        plot(calspots(i).Centroid(1),calspots(i).Centroid(2),'rx')
    end
end


calspots = rmfield(calspots,'MajorAxisLength');
calspots = rmfield(calspots,'MinorAxisLength');
calspots = rmfield(calspots,'EquivDiameter');

end

