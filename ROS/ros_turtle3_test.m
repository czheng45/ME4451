%{
[velpub,velmsg] = rospublisher('cmd_vel');
[odom] = rossubscriber('odom');
[magno] = rossubscriber('magnetic_field');
%}

while(1)
    
   chk = receive(odom);
   mg = receive(magno);
  
   
   clc
   pt = chk.Pose.Pose.Position;
   fprintf('pX:%9.6f   pY:%9.6f   pZ:%9.6f\n',pt.X,pt.Y,pt.Z);
   or = chk.Pose.Pose.Orientation;
   oreul = quat2eul([or.W,or.X,or.Y,or.Z]);
   fprintf('tX:%9.6f   tY:%9.6f   tZ:%9.6f\n',oreul(3),oreul(2),oreul(1));
   
   mgdata = mg.MagneticField_;
   fprintf('mX:%9.6f   mY:%9.6f   mZ:%9.6f\n',10000*mgdata.X,10000*mgdata.Y,10000*mgdata.Z);
   
    
end