clear all;

openfig('maze2.fig');
load('BFS.mat');

visited = zeros([720,1280],'logical');
hold on
for r = 1:720
    for c = 1:1280
        parentpt = [r,c];
        while (BFSmap.map(parentpt(1),parentpt(2),1) ~= 0) && ~visited(parentpt(1),parentpt(2))
            prev = parentpt;
            visited(prev(1),prev(2)) = 1;
            parentpt(1) = BFSmap.map(prev(1),prev(2),1);
            parentpt(2) = BFSmap.map(prev(1),prev(2),2);
            plot([prev(2),parentpt(2)],[prev(1),parentpt(1)],'--m');
        end
    end
end
