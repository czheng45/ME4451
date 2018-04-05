clear;
clc;
rng(4451);
pq = PriorityQueue(@DJNode,[10,10]);

wow = randi(10000,[600,3]);

for q = 1:length(wow)
    pq.enqueue(DJNode(wow(q,1),wow(q,2),wow(q,3)));
end

wow2 = zeros([600,3]);
p = 1;
while pq.queueSize ~= 0
	temp = pq.dequeue();
    wow2(p,:) = [temp.pathlength,temp.r,temp.c];
    p = p+1;
end

[~,idx] = sort(wow(:,1));
wow = wow(idx,:);
wow == wow2;