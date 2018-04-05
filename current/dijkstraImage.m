function parents = dijkstraImage(binim,s)
	nodes = BinaryWrapper(binim);
	touched = BinaryWrapper(binim);
	parents = ArrayWrapper(zeros([size(binim),2],'int32'));
	nextPath = PriorityQueue(size(binim));

	s = int32([0,s]);
	nextPath.enqueue(s);
	touched.setData(s(2),s(3),false);
	while nextPath.queueSize > 0
		s = nextPath.dequeue();
		if touched.getData(s(2)+1,s(3))
			nextPath.enqueue([s(1) + 1,s(2) + 1,s(3)]);
			touched.setData(s(2) + 1,s(3),false);
			parents.setData(s(2) + 1,s(3),[s(2),s(3)]);
		end
		if touched.getData(s(2)-1,s(3))
			nextPath.enqueue([s(1) + 1,s(2) - 1,s(3)]);
			touched.setData(s(2) - 1,s(3),false);
			parents.setData(s(2) - 1,s(3),[s(2),s(3)]);
		end
		if touched.getData(s(2),s(3)+1)
			nextPath.enqueue([s(1) + 1,s(2),s(3) + 1]);
			touched.setData(s(2),s(3) + 1,false);
			parents.setData(s(2),s(3) + 1,[s(2),s(3)]);
		end
		if touched.getData(s(2),s(3)-1)
			nextPath.enqueue([s(1) + 1,s(2),s(3) - 1]);
			touched.setData(s(2),s(3) - 1,false);
			parents.setData(s(2),s(3) - 1,[s(2),s(3)]);
		end
	end
end