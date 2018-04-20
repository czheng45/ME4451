classdef Queue < handle
    
    properties
        data int32
        front int32
        back int32
        capacity int32
    end
    
    methods
        function Queue = Queue(imsize) 
			Queue.data = zeros([imsize(1)*imsize(2),2]);
			Queue.capacity = length(Queue.data);
			Queue.front = 1;
			Queue.back = 1;
        end
        
        function size = getSize(Queue)
            size = Queue.back - Queue.front; 
        end
        
        function [] = enqueue(Queue,data)
            Queue.data(Queue.back,:) = data;
            Queue.back = Queue.back + 1;
        end
        
        function dataout = dequeue(Queue)
           if Queue.getSize() > 0
               dataout = Queue.data(Queue.front,:);
               Queue.front = Queue.front + 1;
               return
           end
           dataout = NaN;
        end
        
        function [] = updateindex(Queue)
           Queue.front = mod(Queue.front,Queue.capacity);
           if Queue.front == 0
              Queue.front = 1; 
           end
           Queue.back = mod(Queue.back,Queue.capacity);
           if Queue.back == 0
              Queue.back = 1; 
           end
        end
    end
    
end

