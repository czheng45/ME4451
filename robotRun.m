clear all;
close all;
clc;
addpath(genpath(cd));

%% Webcam Bringup--------------------------------------------------------------
%If you already have a laptop webcam, it's index 2. If not, index 1.
cam = webcam(2);
cam.Resolution = '1280x720';
preview(cam);
pause(3);

%% Zero angle
startim = snapshot(cam);
cangle = findangle(getCalibrationSpots(filterRobotSnapshot(startim), @calibratorMaskBlue));

%FILL THIS OUT
%need to turn robot from 'cangle' to 0;
%

%% Calibrations----------------------------------------------------------------
lengthcal = turtlebot3_lengthCal2(cam,0,0);
startpos = turtlebot3_centercal(cam);

%% CreateMap-------------------------------------------------------------------
startim = snapshot(cam);
map = findMap(startim,lengthcal);

%% Run BFS---------------------------------------------------------------------

path = BFSSelectPath(map, startim, startpos, lengthcal);

%% Spline path------------BROKEN--------------------------------------------
%Doesn't work
%t = 1:size(path.raw,1);
%fr = fit(t',path.raw(:,1),'smoothingspline','SmoothingParam',0.01);
%fc = fit(t',path.raw(:,2),'smoothingspline','SmoothingParam',0.01);

%this shits broken

%% Move Turtlebot--------------------------------------------------------------
%move along path
