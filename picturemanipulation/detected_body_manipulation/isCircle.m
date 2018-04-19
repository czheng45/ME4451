function [bodies] = isCircle(bodies,varargin)
%----------------------------------isCircle------------------------------------
%DESCRIPTION
%   This function takes in an array of region structs
%   (ie outputs from regionprops) and removes the regions that are NOT
%   circular in nature.
%   
%   By default, this is done by:
%     1) comparing if MajorAxisLength is a maximum of X% greater than
%        MinorAxisLength. Default X = 10%
%     2) comparing if the EquivDiameter is within X% above or below the
%        MajorAxisLength. Default, 10%. (10% above or 10% below)
%
%INPUT ARGUMENTS
%   bodies:
%       n x 1 array of region structs. Each struct contains information about
%       some body in the image. The structs MUST CONTAIN:
%         i) MajorAxisLength
%         ii) MinorAxisLength
%         iii) EquivDiameter
%
%   varargin:
%       You may manually specify a threshold by which to discount if something 
%       is a circle. By default, X = 10% (see DESCRIPTION) above. If empty,
%       uses the default value of 10%, or 0.1.
%
%   Example call: bodies = isCircle(bodies)
%
%OUTPUT ARGUMENTS
%   bodies:
%       a [m x 1] array of structs, where m <= n.
%       Each element pertains to a body that was deemed 'adequately circular'
%
%FUNCTION CALLS 
%   None
%------------------------------------------------------------------------------

thresh = 0.1;
if length(varargin) > 0
    thresh = varargin{1};
end

mjax = 0;
miax = 0;
eqax = 0;

removeidx = zeros([length(bodies),1],'logical');
for q = 1:length(bodies)
   mjax = bodies(q).MajorAxisLength;
   miax = bodies(q).MinorAxisLength;
   eqax = bodies(q).EquivDiameter;
   
   if mjax > (miax * (1+thresh))
      %the major and minor axes aren't close enough to be a circle
      removeidx(q) = 1;
   else
       if eqax > (mjax * (1+thresh)) || eqax < (mjax * (1-thresh))
           %the major axis is too far apart from the equivalent diameter
           removeidx(q) = 1;
       end
   end
   
end

bodies(removeidx) = [];

end

