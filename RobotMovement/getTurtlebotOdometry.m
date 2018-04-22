function theta = getTurtlebotOdometry(odometrySubscriber, theta_offset)

% retrieve the odometry data from the ROS subscriber
odomState = receive(odometrySubscriber);
% convert the quaternion nonsense to rotation about Z axis
quat = odomState.Pose.Pose.Orientation;
angles = quat2eul([quat.W quat.X quat.Y quat.Z]);
theta_raw = rad2deg(angles(1));
% account for any theta offset
theta = mod((theta_raw - theta_offset) + 180, 360)-180;
% package up into X, Y, theta

end
