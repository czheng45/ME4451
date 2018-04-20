function [shiftstack] = shiftr1pix(binim)
%takes in a binary array
%creates a nxmx4 array with 1 pixel shifts in each direction. The layers
%are ordered as followed(1->4): up, down, left, right
%the gaps left by a single shift are filled with false

if strcmpi(class(binim),'gpuArray')
    shiftstack = zeros([size(binim),4],'gpuArray');
else
    shiftstack = zeros([size(binim),4]);
end

shiftstack(1:end-1,:,1) = binim(2:end,:);
shiftstack(2:end,:,2) = binim(1:end-1,:);
shiftstack(:,1:end-1,3) = binim(:,2:end);
shiftstack(:,2:end,4) = binim(:,1:end-1);

end

