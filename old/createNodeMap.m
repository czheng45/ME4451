function [nodes,neighbors] = createNodeMap(binim,alongborder,inopen,linkthresh,rngesus)
	[rborder,cborder,binborders] = borderptsGPU(binim,alongborder,rngesus);
	[ropen,copen] = randomptsOpen(binim,inopen,rngesus);
	nodes(:,1) = [rborder;ropen];
	nodes(:,2) = [cborder;copen];
	neighbors = nearestRadialNeighbors(nodes(:,1),nodes(:,2),linkthresh);
	nodes = gather(nodes);
	neighbors = cellfun(@gather,neighbors,'UniformOutput',false);
end