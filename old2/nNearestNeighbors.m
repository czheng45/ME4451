function [neighborHolder] = nNearestNeighbors(nodeHolder, n)

	neighborHolder = NeighborHolder(nodeHolder,n);
	distArr = bsxfun(@minus,nodeHolder.coords(:,1)',nodeHolder.coords(:,1)).^2;
	distArr = distArr + bsxfun(@minus,nodeHolder.coords(:,2)',nodeHolder.coords(:,2)).^2;
	distArr = distArr.^0.5;
	[distArr,orderArr] = sort(distArr,2);

	numcoords = size(orderArr,1);
	coordidx = 0;
%{
	
	for q = 1:numcoords %row indexer
		p = 2; %coordinate indexer. We know p = 1 is going to be itself

		%find(isnan(neighborHolder.neighborIdx(q,:)),1); %index of first non-filled node
		nth = 1;
		while any(isnan(neighborHolder.neighborIdx(q,:)))
			if p > numcoords
				break; %this is only if we've gone through every point and there arent n neighbors available
			end
			coordidx = orderArr(q,p);
			%blacklist(nodeHolder.coords(q,:),nodeHolder.coords(coordidx,:))
			%if it isn't blacklisted
				neighborHolder.neighborIdx(q,nth) = coordidx;
				neighborHolder.neighborDistance(q,nth) = distArr(q,p);
				neighborHolder.neighborIdx(coordidx,nth) = q;
				nth = nth + 1;
			%else, it is blacklisted

			p = p+1;
		end
	end
	%}

end