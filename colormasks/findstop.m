function [stop] = findstop(pic)

% Convert RGB image to chosen color space
I = rgb2hsv(pic);

%% Red
%Creates a mask for red values

% Define thresholds for channel 1 based on histogram settings
channel1Min = 0.964;
channel1Max = 0.042;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 0.536;
channel2Max = 1.000;

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


end
