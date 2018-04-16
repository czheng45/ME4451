function [out,start,stop] = picbound(picname,expand)

% User input for photo
% Get user input to decide what time frame is being used
% prompt1 = 'What is the expansion value?';
% x1 = inputdlg(prompt1);
% expand = str2double(x1{1});

%For a known file location
%filepath = fullfile('c:\','Users','Jevons','Documents','ME Robotics','Final Project','MyCode','trial.bmp');
%I = imread(filepath);

%Read and show picture
I = imread(picname);


% Convert to grayscale and then Binary occupancy grid
Igray = rgb2gray(I);
Ibw = imbinarize(Igray,.45);
Ibw = imcomplement(Ibw);
%Ibw = Igray < 50;  %Ibw, logical (Different way to get binary)

%Use Ibw as matrix input
map = robotics.BinaryOccupancyGrid(Ibw);
%figure(1)
%show(map)

%Inflate objects
inflate(map,expand)
%figure(2)
%show(map)

%Find stop location(red)
red = I(:,:,1)>200 & I(:,:,2)==0 & I(:,:,3)==0;
rcoord = regionprops(red,'Centroid');
if isempty(rcoord)
   warning('An ending coordinate could not be found'); 
   stop = [];
else
   stop = [rcoord.Centroid(1) rcoord.Centroid(2)];
end


%Find start location(green)
green = I(:,:,1)>140 & I(:,:,2)>180 & I(:,:,3)<100;
gcoord = regionprops(green,'Centroid');
if isempty(rcoord)
   warning('A starting coordinate could not be found');
   start = [];
else
   start = [gcoord.Centroid(1) gcoord.Centroid(2)];
end


out = ~(occupancyMatrix(map));





%% Boundaries

% BW_filled = imfill(BW2,'holes');
% boundaries = bwboundaries(BW_filled);





% hold on
% for k=1:length(boundaries)
%    b = boundaries{k};
%    plot(b(:,2),b(:,1),'g','LineWidth',2);
% end
% button = questdlg('Does this look correct?','Photo','Yes','No','Yes');
% if strcmp(button,'No')
% else
% end



end
%% Future addons

%button = questdlg('Is this the correct photo?','Photo','Yes','No','Yes');
%if strcmp(button,'No')
%else
