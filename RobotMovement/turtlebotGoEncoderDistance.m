function turtlebotGoEncoderDistance(distance1, velocityPublisher, odometrySubscriber)
distance = distance1 * 0.028;
% set default speed
forwardSpeed = .1;

odometryStateE1 = getTurtleBotEncoder(odometrySubscriber, 0);
offset = odometryStateE1;

% use existing theta as the offset angle (new theta should read 0)
odometryStateE = getTurtleBotEncoder(odometrySubscriber, offset);



while(odometryStateE < distance)
    
    
    % send velocity command
    forwardSpeed = sign(distance)*abs(forwardSpeed);
    turtlebotSendSpeed(forwardSpeed, 0, velocityPublisher);
    % pause for timing
    pause(.01);
    
   odometryStateE = getTurtleBotEncoder(odometrySubscriber, offset);

end

turtlebotStop(velocityPublisher);


end
