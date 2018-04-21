function [gradmap] = BFSImage(binim,s)
    rng(4451);
    

    gradmap.end = s;
	nodes = BinaryWrapper(binim);
	touched = BinaryWrapper(binim);
	pathlength = ArrayWrapper(zeros([size(binim),1],'int32'));
	nextPath = Queue(size(binim));

	s = int32([s,0]);
	nextPath.enqueue(s);
	touched.setData(s(1),s(2),false);
	while nextPath.getSize() > 0
		s = nextPath.dequeue();
		if touched.getData(s(1)+1,s(2))
			nextPath.enqueue([s(1) + 1,s(2),s(3) + 1]);
			touched.setData(s(1) + 1,s(2),false);
		end
		if touched.getData(s(1)-1,s(2))
			nextPath.enqueue([s(1) - 1,s(2),s(3) + 1]);
			touched.setData(s(1) - 1,s(2),false);
		end
		if touched.getData(s(1),s(2)+1)
			nextPath.enqueue([s(1),s(2) + 1,s(3) + 1]);
			touched.setData(s(1),s(2) + 1,false);
		end
		if touched.getData(s(1),s(2)-1)
			nextPath.enqueue([s(1),s(2) - 1,s(3) + 1]);
			touched.setData(s(1),s(2) - 1,false);
        end
        pathlength.setData(s(1),s(2),s(3));
    end
    
    gradmap.map = pathlength.data;
    
end