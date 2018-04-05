function parents = dijkstraImage(binim,s)
	touched = BinaryWrapper(binim);
	parents = ArrayWrapper(zeros([size(binim),2],'int16'));
	nextPath = PriorityQueue(@DJNode,size(binim));

	node = DJNode(0,s(1),s(2));
	coords = int16([0,0,0,0,0,0,0]);
	nextPath.enqueue(node);
	touched.setData(s(1),s(2),false);

	while nextPath.queueSize() > 0
		node = nextPath.dequeue();
		coords(1) = node.r+1;
		coords(2) = node.r-1;
		coords(3) = node.r;
		coords(4) = node.c+1;
		coords(5) = node.c-1;
		coords(6) = node.c;
		coords(7) = node.pathlength + 1;

		if touched.getData(coords(1),coords(6))
			nextPath.enqueue(DJNode(coords(7),coords(1),coords(6)));
			touched.setData(coords(1),coords(6),false);
			parents.setData(coords(1),coords(6),[coords(3),coords(6)]);
		end
		if touched.getData(coords(2),coords(6))
			nextPath.enqueue(DJNode(coords(7),coords(2),coords(6)));
			touched.setData(coords(2),coords(6),false);
			parents.setData(coords(2),coords(6),[coords(3),coords(6)]);
		end
		if touched.getData(coords(3),coords(4))
			nextPath.enqueue(DJNode(coords(7),coords(3),coords(4)));
			touched.setData(coords(3),coords(4),false);
			parents.setData(coords(3),coords(4),[coords(3),coords(6)]);
		end
		if touched.getData(coords(3),coords(5))
			nextPath.enqueue(DJNode(coords(7),coords(3),coords(5)));
			touched.setData(coords(3),coords(5),false);
			parents.setData(coords(3),coords(5),[coords(3),coords(6)]);
		end
	end
end