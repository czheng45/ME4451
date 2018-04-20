function [djmap] = BFSImage(binim,s)
    rng(4451);
    

    djmap.start = s;
	nodes = BinaryWrapper(binim);
	touched = BinaryWrapper(binim);
	parents = ArrayWrapper(zeros([size(binim),2],'int32'));
	nextPath = Queue(size(binim));

	s = int32([s]);
	nextPath.enqueue(s);
	touched.setData(s(1),s(2),false);
	while nextPath.getSize() > 0
		s = nextPath.dequeue();
		if touched.getData(s(1)+1,s(2))
			nextPath.enqueue([s(1) + 1,s(2)]);
			touched.setData(s(1) + 1,s(2),false);
			parents.setData(s(1) + 1,s(2),[s(1),s(2)]);
		end
		if touched.getData(s(1)-1,s(2))
			nextPath.enqueue([s(1) - 1,s(2)]);
			touched.setData(s(1) - 1,s(2),false);
			parents.setData(s(1) - 1,s(2),[s(1),s(2)]);
		end
		if touched.getData(s(1),s(2)+1)
			nextPath.enqueue([s(1),s(2) + 1]);
			touched.setData(s(1),s(2) + 1,false);
			parents.setData(s(1),s(2) + 1,[s(1),s(2)]);
		end
		if touched.getData(s(1),s(2)-1)
			nextPath.enqueue([s(1),s(2) - 1]);
			touched.setData(s(1),s(2) - 1,false);
			parents.setData(s(1),s(2) - 1,[s(1),s(2)]);
		end
    end
    
    djmap.map = parents.data;
    
end