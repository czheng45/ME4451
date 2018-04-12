clear;
close all;
clc;



binim = imbinarize(rgb2gray(imread('test1.png')),0.5);
%binim = ones([20,30],'logical');
%binim(6:10,6:10) = zeros(5);
%s = [3,5];
%e = [18,25];
%imshow(image);
s = [134,99];
e = [450,359];
if binim(s(1),s(2)) == false
   error('Start out of bounds'); 
end
if binim(e(1),e(2)) == false
   error('End out of bounds');
end
tic
hello = dijkstraImage(binim,s);
toc
%tic
%showDijkstra(binim,hello,e);
%toc
