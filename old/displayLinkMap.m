function [] = displayLinkMap(binim, nodes, neighbors)

	imshow(binim);
	hold on
	plot(nodes(:,2),nodes(:,1),'rx');
	for q = 1:length(neighbors)
		current = nodes(q,:);
		for p = 1:length(neighbors{q}(:,1))
			plot([current(2),neighbors{q}(p,2)],[current(1),neighbors{q}(p,1)],':b');
		end
	end
end