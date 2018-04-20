function [path] = genPath(djmap,endpt)

returnmap = djmap.map;
parentpt = endpt;
path.start = djmap.start;
path.end = endpt;
path.path = [];
iter = 1;

while(parentpt(1) ~= 0) 
    path.path(iter,:) = parentpt;
    parentpt = [returnmap(parentpt(1),parentpt(2),1),returnmap(parentpt(1),parentpt(2),2)];
    iter = iter+1;
end

if size(path.path,1) == 1
   warning('Invalid starting location specified. Cannot reach end point!');
   path.path = [NaN,NaN];
   return;
end

if path.start ~= path.path(end,:)
    warning('The robot cannot reach the endpoint.');
end

path.path = path.path(end:-1:1,:);

end

