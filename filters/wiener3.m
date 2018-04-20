function [filtercolorim] = wiener3(colorim,varargin)
%-----------------------------------wiener3------------------------------------
%DESCRIPTION
%   Applies a wiener filter to a color image by applying wiener2 to each
%	channel of the RGB image
%
%INPUT ARGUMENTS
%   colorim:
%       RGB image to be filtered
%
%	varargin:
%		[1 x 2] matrix of the smoothing area. Default is [11,11] pixels
%
%   Example call: filterim = wiener3(roboimage)
%
%OUTPUT ARGUMENTS
%   filtercolorim:
%       filtered image.
%
%FUNCTION CALLS 
%   wiener2
%
%------------------------------------------------------------------------------

reg = [11,11];

if length(varargin) > 0
   reg = varargin{1}; 
end

filtercolorim = zeros(size(colorim),'uint8');

for q = 1:3
   filtercolorim(:,:,q) = wiener2(colorim(:,:,q),reg); 
end


end

