function [path] = BFSSelectPath(map, image, start, lengthcal)
bounds = bwboundaries(map);

BFSmap = BFSImage(map,start); %get the total paths to every pt from start


figure
imshow(image);
hold on
for q = 1:length(bounds)
    plot(bounds{q}(:,2),bounds{q}(:,1),'r');
end
plot(start(2),start(1),'rx');
title('Select an ending destination');

endpt = ginput(1);
endpt = round(endpt(end:-1:1)); %get the ending coordinate

path = genPath(BFSmap,endpt); %backtrace the parents grid to get coords
%in order.

for q = 1:size(path.path,1) - 1
    plot([path.path(q,2),path.path(q+1,2)],...
         [path.path(q,1),path.path(q+1,1)],...
         '--g');
end %plot the path
plot(path.path(end,2),path.path(end,1),'rx');
title('Path to be traveled');

path.raw = path.path;
path.path = path.path.*lengthcal;
path.start = path.start.*lengthcal;
path.end = path.end.*lengthcal;

end

