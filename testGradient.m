clear;
close all;
clc;
load('maze1.mat');
cal = 0.2;
map = findMap(pic,cal);

[path] = BFSSelectPath(map, pic, 0, cal);
grad = double(path.map);
grad(grad == 0) = NaN;
grad = -grad;

r = [1:720];
c = [1:1280]';

figure
surface(c,r,grad);
[fx,fy] = gradient(grad);
figure
quiver(c,r,fx,fy);


