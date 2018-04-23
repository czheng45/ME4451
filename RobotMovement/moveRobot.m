clc; close all;
%rosinit('192.168.10.114');
%%
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