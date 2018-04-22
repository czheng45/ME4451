fprintf('What did I say about running this as a script?!');
return;
%------------------------------------------------
% DON'T RUN THIS SCRIPT
% RUN EACH CODE BLOCK INDPENDENTLY (ctrl+enter)
%------------------------------------------------

%% Initialize Turtlebot connection through ROS
turtlebot_ip = '192.168.10.54';% <-- put the IP of the turtlebot you want to use here
rosinit(turtlebot_ip);  

%% Get Publishers and Subscribers
% create a publisher to use to send velocites to robot
velocityPublisher = rospublisher('/mobile_base/commands/velocity');
% create a subscriber to receive odometry information from robot
odometrySubscriber = rossubscriber('/odom');

%% Some Velocity Stuff

% use rosmessage to determine the type of message velocityPublisher uses
velocityMessage = rosmessage(velocityPublisher);
% set parameters of the message
velocityMessage.Linear.X = forwardSpeed;
velocityMessage.Linear.Y = 0;
velocityMessage.Linear.Z = 0;
velocityMessage.Angular.Z = turnSpeed;
% send the message over the publisher to the robot
send(velocityPublisher,velocityMessage);

%% Some odometry stuff

% retrieve the odometry message from the ROS subscriber
odomState = receive(odometrySubscriber);

% show some of the message parameters
% position
odomState.Pose.Pose.Position
% orientation (in quaternion)
odomState.Pose.Pose.Orientation

%% Fun with turtlebots (make it move)

% set the speed parameters
forwardSpeed = 0.1;
rotationSpeed = 1;

% set the run time
runtime = 1;    %seconds
timeInterval = 0.01;
n_intervals = floor(runtime/timeInterval);

% run robot for specified run time
for i = 1:n_intervals
    
    turtlebotSendSpeed(forwardSpeed, rotationSpeed, velocityPublisher);
    
    pause(timeInterval);
end

%% Make a rectangle

turtlebotGoDistance(distance, velocityPublisher, odometrySubscriber);
turtlebotTurnAngle(theta, velocityPublisher, odometrySubscriber);


%% DON'T FORGET TO DO THIS
rosshutdown