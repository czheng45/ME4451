function [out] = boundExpand(logicalmap,expandnum)

%map = robotics.BinaryOccupancyGrid(logicalmap);
%figure
%show(map)

%Inflate objects
%inflate(map,expandnum)

out = ~imdilate(logicalmap,strel('disk',ceil(expandnum),8));
%figure
%show(map)
%out = ~(occupancyMatrix(map));
end
