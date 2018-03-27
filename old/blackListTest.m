clear all;
%close all;
fclose all;
clc;

binim = [[1,1,1,1,1,1,1,1,1];
		 [1,1,1,1,0,1,1,1,1];
		 [1,1,1,1,0,1,1,1,1];
		 [1,1,1,1,0,1,1,1,1];
		 [1,1,1,1,0,1,1,1,1];
         [1,1,1,1,0,1,1,1,1];
         [1,1,1,1,0,1,1,1,1];
         [1,1,1,1,0,1,1,1,1];
         [1,1,1,1,0,1,1,1,1]];

pt = [2,4];
[a,b] = ind2sub(size(binim),reshape(magic(9),[81,1]));
neighbors{1} = [a,b];
blacklist = find(~binim);

mask = blackListPath(blacklist,pt,neighbors{1},size(binim));
neighbors{1} = neighbors{1}(mask,:);

displayLinkMap(binim,pt,neighbors);