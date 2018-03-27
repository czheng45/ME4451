classdef NeighborHolder < handle

	properties
		nodeHolder
		neighborIdx
		neighborDistance
	end

	methods
		function NeighborHolder = NeighborHolder(nodeHolder,nNeighbors)
			NeighborHolder.nodeHolder = nodeHolder;
			NeighborHolder.neighborIdx = NaN([length(nodeHolder.ind),nNeighbors]);
			NeighborHolder.neighborDistance = NeighborHolder.neighborIdx;
		end
	end
end