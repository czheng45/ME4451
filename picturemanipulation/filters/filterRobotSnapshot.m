function [image] = filterRobotSnapshot(image)
%----------------------------filterRobotSnapshot-------------------------------
%DESCRIPTION
%   Filters an overhead image of the turtlebot3, enhancing the calibration
%	spots and darkening/dulling the background for better calspot detection
%
%   Uses a median measured intensity of median(greyscale im) to adjust
%   the contrast of an image relative to a 'standard' median intensity of
%   170. This enhances the color filter performances.
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

standard_intensity = 170;

image = wiener3(image);
grim = rgb2gray(image);

avintensity = median(grim(:));
scaleratio = double(avintensity)/standard_intensity;

if scaleratio > 1 %too bright
    scaleratio = scaleratio - 1;
    image = imadjust(image,[scaleratio,scaleratio,scaleratio;1,1,1]);
else
    image = imadjust(image,[0,0,0;scaleratio,scaleratio,scaleratio]);
end

image = image - getBGDmap(image);
image = imadjust(image,[0.4,0.4,0.4;1,1,1]);

end

