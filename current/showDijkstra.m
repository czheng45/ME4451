function [] = showDijkstra(binim,route,varargin)

	imshow(binim);
	hold on;
	parentpt = zeros([1,1,2]);
	for r = 1:size(route.data,1)
		for c = 1:size(route.data,2)
			parentpt = route.getData(r,c);
			if parentpt(1) ~= 0
				plot([c,parentpt(2)],[r,parentpt(1)],'--b');
			end
		end
	end

	if ~isempty(varargin)
		currpt = varargin{1};
		parentpt = route.getData(currpt(1),currpt(2));
		plot(currpt(2),currpt(1),'gx');
		while parentpt(1) ~= 0
			plot([parentpt(2),currpt(2)],[parentpt(1),currpt(1)],'--g');
			currpt = parentpt;
			parentpt = route.getData(currpt(1),currpt(2));
		end
		plot(currpt(2),currpt(1),'rx');

	end

end