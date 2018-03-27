clear;
clc;

rng(4451);
binim = logical(round(rand(10)));
indones = find(binim);
nodes = NodeHolder(indones,size(binim));
neighbors = nNearestNeighbors(nodes,5);