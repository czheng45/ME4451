function [path] = djSelectPath(map, image, start, lengthcal)

djmap = dijkstraImage(map,start);
figure
imshow(map);
title('Select an ending destination');
endpt = ginput(1);
endpt = round(endpt(end:-1:1));
path = genPath(djmap,endpt);

hold on
plot(path.path(1,2),path.path(1,1),'rx');
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

