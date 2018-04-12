clear;
clc;

load('dijdatatest');
parentpt = [450,359];
path = [];
iter = 1;
while(parentpt(1) ~= 0) 
    path(iter,:) = parentpt;
    parentpt = [returnmap(parentpt(1),parentpt(2),1),returnmap(parentpt(1),parentpt(2),2)];
    iter = iter+1;
end
path = path(end:-1:1,:);