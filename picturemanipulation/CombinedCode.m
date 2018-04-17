%takeimage
clear
%Setting up camera settings
cam = webcam(2);
cam.Resolution = '1280x720';
cam.Brightness = 100;
cam.Contrast = 1;
cam.Exposure = -8;
cam.FocusMode = 'Auto';

%Take pictur

pic = snapshot(cam);
figure(1)
image(pic)
%%
% Convert RGB image to chosen color space
I = rgb2hsv(pic);

%% Red
%Creates a mask for red values

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.964;
channel1Max = 0.042;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.536;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.487;
channel3Max = 1.000;

% Create mask based on chosen histogram thresholds
sliderRed = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderRed;

% Initialize output masked image based on input image.
maskedRGBImage = pic;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
figure(1)
image(maskedRGBImage)
redcoord = regionprops(sliderRed,'Centroid','Area');
%% Find Largest Red location

if isempty(redcoord)
   warning('An ending coordinate could not be found'); 
   stop = [];
else
   [val,ind] = max([redcoord.Area]);
   redloc = redcoord(ind).Centroid;
   stop = [redloc(1) redloc(2)]; %x and then y
end

%% Green
%Creates a mask for green values

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.219;
channel1Max = 0.500;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.447;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.251;
channel3Max = 0.569;

% Create mask based on chosen histogram thresholds
sliderGreen = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderGreen;

% Initialize output masked image based on input image.
maskedRGBImage = pic;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
figure(2)
image(maskedRGBImage)
greencoord = regionprops(sliderGreen,'Centroid','Area');
%% Find Largest Green location

if isempty(greencoord)
   warning('A starting coordinate could not be found');
   start = [];
else
   [val,ind] = max([greencoord.Area]);
   greenloc = greencoord(ind).Centroid;
   start = [greenloc(1) greenloc(2)];
end

%% Black
%Creates a mask for green values

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.633;
channel1Max = 0.628;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.001;
channel2Max = 0.793;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.108;
channel3Max = 0.260;

% Create mask based on chosen histogram thresholds
sliderBlack = ( (I(:,:,1) >= channel1Min) | (I(:,:,1) <= channel1Max) ) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBlack;

% Initialize output masked image based on input image.
maskedRGBImage = pic;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
figure(3)
image(maskedRGBImage)
blackcoord = regionprops(sliderBlack,'Centroid','Area');
%%
imshow(pic)
Igray = rgb2gray(pic);
figure(4)
image(Igray)

Ibw = imbinarize(Igray,.45);
figure(5)
image(Ibw)

map = robotics.BinaryOccupancyGrid(Ibw);
figure(2)
show(map)

inflate(map,10)
figure(3)
show(map)


%% Expand Black objects

%Ibw = imcomplement(BW); %Want objects to be "white"
Igray = rgb2gray(maskedRGBImage);
Ibw = imbinarize(Igray,.45);
%Use Ibw as matrix input
map = robotics.BinaryOccupancyGrid(BW);
figure(1)
show(map)

inflate(map,10)
figure(2)
show(map)

out = ~(occupancyMatrix(map));
%% Blue
%Creates a mask for green values

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.493;
channel1Max = 0.774;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.602;
channel2Max = 1.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 0.416;
channel3Max = 0.720;

% Create mask based on chosen histogram thresholds
sliderBlue = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBlue;

% Initialize output masked image based on input image.
maskedRGBImage = pic;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
figure(4)
imshow(maskedRGBImage)
bluecoord = regionprops(sliderBlue,'Centroid','Area');

%% Angle between 2 blue areas
%Finds angles between blue areas

%Need to find top 3 areas 
blue = [bluecoord.Area];
[b,Index] = sort(blue,'descend');
top2 = b(1:2);
top2coord = Index(1:2);
one = bluecoord(top2coord(1)).Centroid;                                     %Had a hard time with structs
two = bluecoord(top2coord(2)).Centroid;
angleRad = atan((two(1)-one(1))/(two(2)-one(2)));                        %Need to test with real examples
angle = rad2deg(angleRad);