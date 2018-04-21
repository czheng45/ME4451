function [path] = BFSSelectPath(map, image, start, lengthcal)
bounds = bwboundaries(map);

figure
imshow(image);
hold on
for q = 1:length(bounds)
    plot(bounds{q}(:,2),bounds{q}(:,1),'r');
end

start = ginput(1);
start = round(start(end:-1:1)); %get the ending coordinate
plot(start(2),start(1),'rx');
title('Select an ending destination');
endpt = ginput(1);
endpt = round(endpt(end:-1:1)); %get the ending coordinate

BFSmap = BFSImage(map,start); %get the total paths to every pt from start



%path.raw = path.path;
%path.path = path.path.*lengthcal;
%path.start = path.start.*lengthcal;
%path.end = path.end.*lengthcal;
path = BFSmap;

end

