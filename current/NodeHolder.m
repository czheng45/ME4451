classdef NodeHolder < handle
	properties
		ind
		coords
		%dtemp
		%idxs
	end

	methods
		function NodeHolder = NodeHolder(ind,imsize)
			temp = size(ind);
			if temp(2) ~= 1
				ind = reshape(ind,[length(ind),1]);
			end
			NodeHolder.ind = ind;
			[NodeHolder.coords(:,1),NodeHolder.coords(:,2)] = ind2sub(imsize,ind);
			%NodeHolder.dtemp = zeros([length(ind),1]);
			%NodeHolder.idxs = idxs;
		end

%{
		function [] = resetTemps(NodeHolder)
			NodeHolder.dtemp = zeros([length(NodeHolder.dtemp),1]);
			NodeHolder.idxs = NodeHolder.dtemp;
		end	
%}

	end
end