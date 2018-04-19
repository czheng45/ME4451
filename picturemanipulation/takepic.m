function [pic] = takepic(num)
%takeimage
%Setting up camera settings
cam = webcam(2);
cam.Resolution = '1280x720';
cam.Brightness = 100;
cam.Sharpness = 50;
cam.Contrast = 1;
cam.Exposure = -8;
cam.FocusMode = 'Auto';

%Take picture
preview(cam);
pause;
pic = snapshot(cam);
figure(1)
image(pic)
end
