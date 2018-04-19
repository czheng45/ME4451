function [bodies] = sizeCutoff(bodies,varargin)
%--------------------------------sizeCutoff------------------------------------
%DESCRIPTION
%   This function takes in an array of region structs
%   (ie outputs from regionprops) and removes the regions that are NOT
%   large enough to form an adequate circle of diameter 7 pixels.
%   
%   By default, this is done by simply comparing the body Area to
%	the threshold area
%
%INPUT ARGUMENTS
%   bodies:
%       n x 1 array of region structs. Each struct contains information about
%       some body in the image. The structs MUST CONTAIN:
%         i) Area
%
%   varargin:
%       You may manually specify a minimum area threshold.
%		The default is 83.
%
%   Example call: bodies = sizeCutoff(bodies);
%
%OUTPUT ARGUMENTS
%   bodies:
%       a [m x 1] array of structs, where m <= n.
%       Each element pertains to a body that was of an adequate Area
%
%FUNCTION CALLS 
%   None
%------------------------------------------------------------------------------

sizethresh = 83;

if length(varargin) > 0
    sizethresh = varargin{1};
end

removeidx = zeros([length(bodies),1],'logical');

for q = 1:length(bodies)
    if bodies(q).Area < sizethresh
       removeidx(q) = 1; 
    end
end

bodies(removeidx) = [];


end

