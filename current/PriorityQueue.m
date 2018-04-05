classdef PriorityQueue < handle
	properties
		constructor
		heap
		hsize int32
		swip logical
		temp
	end

	methods
		function PriorityQueue = PriorityQueue(constructor,imsize) 
			if ~strcmpi(class(constructor),'function_handle')
				error(['Needs a class constructor with default vals to initialize!',
					   'That being said	a class constructor is a function handle so',
					   'technically you just need a function handle. But it is undefined',
					   'behavior if you use a random function handle']);
			end
			PriorityQueue.constructor = constructor;
			PriorityQueue.heap = constructor();
			PriorityQueue.heap(imsize(1)*imsize(2)) = constructor();
			PriorityQueue.hsize = 0;
			swip = 0;
		end

		function [] = enqueue(pq, dat)
			%data must be of the same type as initialized in the constructor

			if (pq.hsize+1) > length(pq.heap)
				pq.heap(2*length(pq.heap)) = pq.constructor(); %double heap size if array exceeded
			end
			pq.hsize = pq.hsize + 1;
			pq.heap(pq.hsize) = dat;
			pq.upheap();
		end

		function node = dequeue(pq)
			if pq.hsize == 0
				error('Queue is empty');
			end
			node = pq.heap(1);
			pq.heap(1) = pq.heap(pq.hsize);
			pq.heap(pq.hsize) = pq.constructor();
			pq.hsize = pq.hsize - 1;
			pq.downheap();
		end

		function [] = clear(pq)
			if (pq.hsize > 0) 
				pq.temp = pq.constructor();
				pq.heap = pq.constructor();
				pq.heap(pq.hsize) = pq.constructor();
				pq.hsize = 0;
			end
			
		end

		function qsize = queueSize(pq)
			qsize = pq.hsize;
		end

	end

	methods (Access = 'private')

		function [] = upheap(pq)
			idx = pq.hsize;
			parentnode = idivide(idx, 2, 'floor');
			while(true)
				if (parentnode >= 1) && (pq.heap(idx).compareTo(pq.heap(parentnode)) < 0)
					pq.swap(idx,parentnode);
					idx = parentnode;
					parentnode = idivide(idx, 2, 'floor');
				else
					return;
				end
			end
		end

		function [] = downheap(pq)
			idx = int32(1);
			while(true)
				child1 = idx*2;
				child2 = idx*2 + 1;
				if child1 > pq.hsize
					return;
				end

				if child2 > pq.hsize
					if pq.heap(idx).compareTo(pq.heap(child1)) > 0
						pq.swap(idx,child1);
					end
					return;
				end

				if pq.heap(idx).compareTo(pq.heap(child1)) > 0 || pq.heap(idx).compareTo(pq.heap(child2)) > 0
					if pq.heap(child1).compareTo(pq.heap(child2)) == 0
						if pq.swip == 1
							pq.swip = 0;
							pq.swap(idx,child1);
							idx = child1;
						else
							pq.swip = 1;
							pq.swap(idx,child2);
							idx = child2;
						end

					elseif pq.heap(child1).compareTo(pq.heap(child2)) > 0
						pq.swap(idx,child2);
						idx = child2;

					else
						pq.swap(idx,child1);
						idx = child1;

					end

				else
					return;	
				end

			end
		end

		function [] = swap(pq,a,b)
			pq.temp = pq.heap(a);
			pq.heap(a) = pq.heap(b);
			pq.heap(b) = pq.temp;
		end

	end

end