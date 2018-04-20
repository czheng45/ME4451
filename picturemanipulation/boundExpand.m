function [map] = boundExpand(logicalmap,expandnum)

map = robotics.BinaryOccupancyGrid(logicalmap);
figure
show(map)

%Inflate objects
inflate(map,expandnum)
figure
show(map)

end
