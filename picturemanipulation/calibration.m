function [angle] = calibration(picname)

%take picture 
%see set of 3 points
%change angle
% % URL to get a camera snapshot
% url='http://192.168.0.20/image.jpg';
% img_file='image.jpg';  % temporary file used to store the camera image
% user='admin';       % username and password used to perform authentication
% pass='';
% for i = 1:100
%     % grab the camera image and store it in a local temporary file
%     urlwrite(url,img_file,'Authentication','Basic','Username',user,'Password',pass);
%     % show the camera image and delete the local temporary file
%     cam_capture = imread(img_file);
%     imshow(cam_capture);
% end
% delete(img_file);

%I = imread('cali3.JPG');
I = imread(picname);
Igray = rgb2gray(I);
Ibw = imbinarize(Igray,.45);
Ibw = imcomplement(Ibw);

red = I(:,:,1)>200 & I(:,:,2)==0 & I(:,:,3)==0;                             %Need to be definined by actual colors
rcoord = regionprops(red,'Centroid','Area');
if isempty(rcoord)
   warning('The robot could not be found'); 
   stop = [];
else
   %Need to find top 3 areas 
   r = [rcoord.Area];
   [b,I] = sort(r,'descend');
   top3 = b(1:3);
   top3coord = I(1:3);
   one = rcoord(top3coord(1)).Centroid;                                     %Had a hard time with structs
   two = rcoord(top3coord(2)).Centroid;
   three = rcoord(top3coord(3)).Centroid;
   angleRad = atan((two(1)-one(1))/(two(2)-one(2)));                        %Need to test with real examples
   angle = rad2deg(angleRad);

end
end

