close all;
clear;
clc;

addpath(genpath(cd));

%{
cam = webcam(1);
cam.Resolution = '1280x720';
cam.Sharpness = 50;
cam.ExposureMode = 'auto';
cam.FocusMode = 'auto';

preview(cam);
pause;
%}

load('testim1.mat');

tic
%testim = snapshot(cam);
turtlebot3_lengthcal(testim,'show');
%turtlebot3_lengthcal(testim);
toc

