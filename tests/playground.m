clear
clc

coords =[1,2;3,4;5,6;7,8];
subr = coords;


answer = bsxfun(@minus,coords(:,1)',subr(:,1)).^2;
answer = answer + bsxfun(@minus,coords(:,1)',subr(:,1)).^2;
answer = answer.^0.5
