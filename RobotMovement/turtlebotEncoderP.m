function turtlebotEncoderP(distance1, velocityPublisher, odometrySubscriber)

% default settings for closed-loop(ish) turns
speed = 0.2; %no idea the units
error_tolerance = .01;  %degree
p = 20;
i = 0.015;
d = 0.15;

distance = distance1*0.85;

% get the current angle with no offset
odometryStateE = getTurtleBotEncoder(odometrySubscriber, 0);
offset = odometryStateE;

% use existing theta as the offset angle (new theta should read 0)
odometryStateE = getTurtleBotEncoder(odometrySubscriber, offset);

% determine initial error in theta measurement
error = abs(distance - odometryStateE);

% turn toward the desired theta at default speed until pointing in the
% right direction

cumerror = [0, 0];
out = 0;

while error > error_tolerance
     
    forwardSpeed =  sign(distance - odometryStateE) * speed * (sum(cumerror)*i + error* p + d/.005 * abs(cumerror(end) - cumerror(end-1)) );
    turtlebotSendSpeed(forwardSpeed, 0, velocityPublisher)
    
    
    % check current odometry again and calculate error
    odometryStateE = getTurtleBotEncoder(odometrySubscriber, offset);
    
    error = abs(distance - odometryStateE);
    out = [out odometryStateE];


    % short pause so we don't clog the system
    pause(0.005)
    
    cumerror = [cumerror,  error];
   

end
%plot(out)
%hold on;
turtlebotStop(velocityPublisher);