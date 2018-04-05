classdef DJNode < handle

	properties
		initialized logical
		pathlength int32
		r int16
		c int16
	end

	methods
		function DJNode = DJNode(pl,r,c)
			if nargin == 0
				DJNode.pathlength = 0;
				DJNode.r = 0;
				DJNode.c = 0;
				DJNode.initialized = false;
			else
				DJNode.pathlength = pl;
				DJNode.r = r;
				DJNode.c = c;
				DJNode.initialized = true;
			end
		end

		function res = compareTo(djna,djnb)
			res = djna.pathlength - djnb.pathlength;
		end
	end

end