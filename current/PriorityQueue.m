classdef PriorityQueue < handle
	properties
		heap int32
		hsize int32
		temp int32
		swip int8
	end

	methods
		function PriorityQueue = PriorityQueue(imsize) 
			PriorityQueue.heap = zeros([imsize(1)*imsize(2),3]);
			PriorityQueue.hsize = 0;
			temp = zeros([1,3]);
			swip = 1;
		end

		function success = enqueue(pq, data)
			%data must be a 1x3 vector with the elements: [pathlength,r,c]
			if pq.hsize+1 > length(pq.heap)
				pq.heap = [pq.heap;zeros(size(pq.heap))];
			end
			if pq.hsize == 0
				pq.heap(1,:) = data;
				pq.hsize = pq.hsize+1;
			else
				pq.hsize = pq.hsize+1;
				pq.heap(pq.hsize,:) = data;
				pq.upheap();
			end
		end

		function node = dequeue(pq)
			if pq.hsize == 0
				error('Queue is empty');
			end
			node = pq.heap(1,:);
			pq.heap(1,:) = pq.heap(pq.hsize,:);
			pq.heap(pq.hsize,:) = [0,0,0];
			pq.hsize = pq.hsize - 1;
			pq.downheap();
		end

		function [] = clear(pq)
			pq.hsize = 0;
			pq.heap = zeros([length(pq.heap),3]);
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
				if parentnode >= 1 && (pq.heap(idx,1) < pq.heap(parentnode,1))
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
					if pq.heap(idx,1) > pq.heap(child1,1)
						pq.swap(idx,child1);
					end
					return;
				end

				if pq.heap(idx,1) > pq.heap(child1,1) || pq.heap(idx,1) > pq.heap(child2,1)
					if pq.heap(child1,1) == pq.heap(child2,1)
						if pq.swip == 1
							pq.swip = 2;
							pq.swap(idx,child1);
							idx = child1;
						else
							pq.swip = 1;
							pq.swap(idx,child2);
							idx = child2;
						end
					elseif pq.heap(child1,1) > pq.heap(child2,1)
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
			pq.temp = pq.heap(a,:);
			pq.heap(a,:) = pq.heap(b,:);
			pq.heap(b,:) = pq.temp;
		end

	end

end