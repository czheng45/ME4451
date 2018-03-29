clear;
clc;
rng(4451);
pq = PriorityQueue([10,10]);

wow = randi(10000,[600,3]);

for q = 1:length(wow)
    if wow(q,1) == 154
        
    end
    pq.enqueue(wow(q,:));
end

wow2 = zeros([600,3]);
p = 1;
while pq.queueSize ~= 0
    wow2(p,:) = pq.dequeue();
    p = p+1;
end

[~,idx] = sort(wow(:,1));
wow = wow(idx,:);
wow == wow2;