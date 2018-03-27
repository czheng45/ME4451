function [r, c, bimborders] = borderptsGPU(binim,numpts,rngesus)
	if numpts <= 0
		error('no');
	end

	binim = gpuArray(binim);
	shiftstack = shiftr1pix(binim);
	bimborders = arrayfun(@isBorderGPU,binim,shiftstack(:,:,1), ...
											 shiftstack(:,:,2), ...
											 shiftstack(:,:,3), ...
											 shiftstack(:,:,4));

	rng(rngesus);
	pts = find(bimborders);

	if numpts <= 1
		numpts = ceil(length(pts)*numpts);
	end
	
	idx = randi(length(pts),[1,numpts]);
	[r,c] = ind2sub(size(binim), pts(idx));
end