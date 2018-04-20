function [obstacles] = filterObstaclesIn(image, robotposition, robotradius)
%------------------------------filterObstaclesIn-------------------------------
%DESCRIPTION
%   Filters an overhead image of the turtlebot3, enhancing the obstacle objects
%	and darkening the background. Also takes in the position of the turtlebot
%	center such that the turtlebot itself is not part of the obstacles.
%
%INPUT ARGUMENTS
%   image:
%       raw image containing the obstacle course
%
%	robotposition:
%		[r,c] position of the turtlebot's center. If empty, assumed that the
%		turtlebot3 is not on the field.
%
%	robotradius:
%		max radius in pixels of the turtlebot3.
%
%   Example call: obstacleim = filterObstaclesIn(roboimage,[100,100],120)
%
%OUTPUT ARGUMENTS
%   obstacles:
%       binary image of the detected obstacles.
%
%FUNCTION CALLS 
%	imadjust
%
%------------------------------------------------------------------------------
%obstacles = image; 
obstacles = image - (getBGDmap(image, 20));
%obstacles = imadjust(obstacles,[0.2,0.2,0.2;.5,.5,.5]);
figure
imshow(obstacles);
obstacles = imbinarize(rgb2gray(obstacles),0.01);

end
