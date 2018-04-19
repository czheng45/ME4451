function [background_map] = getBGDmap(color_image,varargin)
%----------------------------------getBGDmap-----------------------------------
%DESCRIPTION
%	This function returns a value map of the average background intensity of
%	a given that can be used for normalization to brightness of an image to
%	remove shadows.
%
%INPUT ARGUMENTS
%   color_image:
%       Color image for analysis of background intensity.
%
%   varargin:
%       You may manually specify a smoothing area using varargin. Default is
%		100. Smaller values result in a more precise intensity map, but is more
%		likely to mis-identify a non-background feature.
%
%   Example call: bkgd = getBGDmap(robocolorimg)
%
%OUTPUT ARGUMENTS
%   background_map:
%       an RGB image of the background intensities of the image. Though it is
%		RGB, it is effectively greyscale because each channel has the same
%		values.
%       
%
%FUNCTION CALLS 
%   imopen
%	strel
%------------------------------------------------------------------------------

area = 100;

if length(varargin) > 0
   area = varargin{1}; 
end

grey_image = rgb2gray(color_image);
background_map = imopen(grey_image,strel('disk',area,4));
background_map = repmat(background_map,[1,1,3]);

end

