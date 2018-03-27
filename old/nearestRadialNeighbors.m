function [neighbors] = nearestRadialNeighbors(r,c,dthresh)
	neighbors = cell(1,length(r));
	coords = [r,c];

	for q = 1:length(r)
		point = [r(q),c(q)];
		temp = coords;
		temp(q,:) = [];
		rad = sum((temp - point).^2, 2).^0.5;
		possibles = [temp(rad<=dthresh,:),rad(rad<=dthresh)];

		%insert blacklist code here

		neighbors{q} = possibles;
	end
	neighbors = neighbors';
end