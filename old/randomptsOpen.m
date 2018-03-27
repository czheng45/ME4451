function [r,c] = randomptsOpen(binim,numpts,rngesus)

		[r,c] = ind2sub(size(binim),find(binim));
		if numpts < 1
			numpts = ceil(length(r).*numpts);
		end

		rng(rngesus);
		selects = randi(length(r),[1,numpts]);
		r = r(selects);
		c = c(selects);

end