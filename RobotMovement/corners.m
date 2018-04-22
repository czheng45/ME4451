close all

pathlogial = (path == 1); 
cornerspath = corner(path, 'Harris');
plot(cornerspath(:,1), cornerspath(:,2), 'r*');
%imshow(pathlogical); 