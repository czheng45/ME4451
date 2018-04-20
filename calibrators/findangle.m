function [angle] = findangle(calspots)
%% Angle between 2 areas
%Finds angles between areas

%Need to find top 3 areas 
area = [calspots.Area];
[b,Index] = sort(area,'descend');
top2 = b(1:2);
top2coord = Index(1:2);
one = calspots(top2coord(1)).Centroid;
two = calspots(top2coord(2)).Centroid;
angleRad = atan(abs((two(1)-one(1)))/abs((two(2)-one(2))));
angle = rad2deg(angleRad);
if one(1) < two(1) && one(2) > two(2)
    angle = -180+angle;
elseif one(1) > two(1) && one(2) > two(2)
    angle = 90 + 90-angle;
elseif one(1) > two(1) && one(2) < two(2) %top right quadrant
    angle = angle;
elseif one(1) < two(1) && one(2) < two(2)
    angle = -1*angle;
end

end
