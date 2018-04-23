clear all;
close all;
clc;
addpath(genpath(cd));

testmode = 1;
testfile = 'maze5.mat';

%% Webcam Bringup--------------------------------------------------------------
if(~testmode)
%If you already have a laptop webcam, it's index 2. If not, index 1.
cam = webcam(2);
cam.Resolution = '1280x720';
preview(cam);
pause(4);
end

%% Zero angle
if(testmode)
    load(testfile);
    startim = pic;
else
    startim = snapshot(cam);
end

cangle = findangle(getCalibrationSpots(filterRobotSnapshot(startim), @calibratorMaskBlue));

%FILL THIS OUT
%need to turn robot from 'cangle' to 0;
%

%% Calibrations----------------------------------------------------------------
if(testmode)
    startim = filterRobotSnapshot(startim);
else
    startim = filterRobotSnapshot(snapshot(cam));
end

lengthcal = turtlebot3_lengthcal(startim);
startpos = turtlebot3_centercal(startim);

%% CreateMap-------------------------------------------------------------------
if(testmode)
    load(testfile);
    startim = pic;
else
    startim = snapshot(cam);
end

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

velocityPublisher = rospublisher('/cmd_vel');
odometrySubscriber = rossubscriber('/odom');


%% velocity settings
forwardSpeed = 0;
turnSpeed = 0;

% use rosmessage to determine the type of message velocityPublisher uses
velocityMessage = rosmessage(velocityPublisher);
velocityMessage.Linear.X = forwardSpeed;
velocityMessage.Linear.Y = 0;
velocityMessage.Linear.Z = 0;
velocityMessage.Angular.Z = turnSpeed;
% send the message over the publisher to the robot
send(velocityPublisher,velocityMessage);

%% Some odometry stuff

% retrieve the odometry message from the ROS subscriber
odomState = receive(odometrySubscriber);


%sensorState = recieve(sensorSubscriber);

%%


orientation = 0
pathVector = path.path * .01;

odomState = receive(odometrySubscriber);
%turtlebotTurnAngle(outangle, velocityPublisher, odometrySubscriber);
distances = []; 
angles = []; 
xx = []; 
yy = [];

increment = 10;



for (i = increment+1:increment:length(pathVector))
    
    %calculates distance and angle to move robot
    
    y=(pathVector(i,1) - pathVector(i-increment,1))*-1;
    x=(pathVector(i,2) - pathVector(i-increment,2) )*-1;
  
    outdisp = sqrt(y^2 + x^2);
    outangle = atan2d(y, x) - orientation;
    orientation = orientation + outangle;
    
%     %keeps track of robot orientation
%     s = sign(orientation + outangle);
%     orientation =  mod(orientation + outangle, 360);
%     if(orientation > 180)
%         orientation = orientation - 180;
%     end
%     orientation = orientation *s
    
    %moves robot
    odomState = receive(odometrySubscriber);
    turtlebotTurnAngle(-outangle, velocityPublisher, odometrySubscriber);
    
    turtlebotGoEncoderDistance(outdisp, velocityPublisher, odometrySubscriber);
    
end
plot(angles, '*')
