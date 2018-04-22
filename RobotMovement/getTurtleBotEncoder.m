function distance = getTurtleBotEncoder(odometrySubscriber, offset) 

odomState = receive(odometrySubscriber);
distance = abs(abs(odomState.Pose.Pose.Position.Y) - offset);

end