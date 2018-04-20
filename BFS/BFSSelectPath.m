function [path] = BFSSelectPath(map, image, start, lengthcal)

figure
imshow(image);
bounds = bwboundaries(map);
hold on
for q = 1:length(bounds)
    plot(bounds{q}(:,2),bounds{q}(:,1),'r');
end

djmap = BFSImage(map,start);

hold on
plot(start(2),start(1),'rx');
title('Select an ending destination');
endpt = ginput(1);
endpt = round(endpt(end:-1:1));
path = genPath(djmap,endpt);

for q = 1:size(path.path,1) - 1
    plot([path.path(q,2),path.path(q+1,2)],...
         [path.path(q,1),path.path(q+1,1)],...
         '--g');
end
plot(path.path(end,2),path.path(end,1),'rx');

path.raw = path.path;
path.path = path.path.*lengthcal;
path.start = path.start.*lengthcal;
path.end = path.end.*lengthcal;

end

