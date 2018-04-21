function [BFSmap] = BFSSelectPath(map, image, start, lengthcal)
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
if BFSmap.map(endpt(1),endpt(2)) == 10000
    BFSmap = NaN;
    return;
end
if BFSmap.map(start(1),start(2)) == 10000
    BFSmap = NaN;
    return;
end


end

