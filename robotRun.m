clear all;
close all;
clc;
addpath(genpath(cd));

%% Webcam Bringup--------------------------------------------------------------
cam = webcam(2);
cam.Resolution = '1280x720';
preview(cam);
pause(3);

%% Calibrations----------------------------------------------------------------
lengthcal = turtlebot3_lengthCal2(cam,0,0);
startpos = turtlebot3_centercal(cam);

%% CreateMap-------------------------------------------------------------------
startim = snapshot(cam);
map = findMap(startim,lengthcal);

%% Run BFS---------------------------------------------------------------------

path = BFSSelectPath(map, startim, startpos, lengthcal);

%% Spline path-----------------------------------------------------------------

t = 1:size(path.raw,1);
fr = fit(t',path.raw(:,1),'smoothingspline','SmoothingParam',0.01);
fc = fit(t',path.raw(:,2),'smoothingspline','SmoothingParam',0.01);

%% Move Turtlebot--------------------------------------------------------------