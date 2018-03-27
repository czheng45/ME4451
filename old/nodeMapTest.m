clear all
%close all
fclose all
clc

image = imread('test3.png');
binim = imbinarize(rgb2gray(image),0.3);
blacklist = find(~binim);
[nodes,neighbors] = createNodeMap(binim,0.01,0.003,60,4451);
%
tic
for q = 1:length(neighbors)
    %q
	cneighbors = neighbors{q};
	mask = blackListPath(blacklist,nodes(q,:),cneighbors(:,1:2),size(binim));
	neighbors{q} = cneighbors(mask,:);
 
end
toc
displayLinkMap(binim,nodes(:,:),neighbors(:));
toc