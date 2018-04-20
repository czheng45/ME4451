function [start] = findstart(pic)

% Convert RGB image to chosen color space
I = rgb2hsv(pic);

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

end
