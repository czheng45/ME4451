clear
clc

files = {'picNotWorking','picNotWorking2','picNotWorking3','picNotWorking4',...
         'testim1','testim2','testim3','testfield1','testfield2','testfield3'};

masks = {@calibratorMaskBlue,@calibratorMaskPink,@calibratorMaskOrange};
for q = 1:length(files)
   load(files{q});
   
   if q < 5
       testim = pic;
   end
   filtim = filterRobotSnapshot(pic);
   
   for p = 1:length(masks)
       spots = getCalibrationSpots(filtim,masks{p});
       
       if p == 3
           if length(spots) == 1
                status{p} = 'Passed';
           else
                status{p} = 'Failed';
           end
       else
           if length(spots) == 2
                status{p} = 'Passed';
           else
                status{p} = 'Failed';
           end
       end
       
   end
   
   fprintf(['Results for %14s: [Bluecal %s; Pinkcal %s; Orangecal %s]\n'],files{q},status{1},status{2},status{3});
   
   
end