clear
clc
%looks like large array cpu sort beats out the rest.
%gpu has a small edge, but it's not worth the effort.

n = 10;
test = rand(n);

tic
[plainersort,plainsort] = sort(test,2);
toc

tic
forsort = zeros(n);
for q = 1:size(test,1)
   forsort(q,:) =  sort(test(q,:));
end
toc

%{
tic
parforsort = zeros(n);
parfor q = 1:size(test,1);
   parforsort(q,:) = sort(test(q,:)); 
end
toc

tic
gpuN = gpuArray(test);
gpusort = sort(gpuN,2);
cpuN = gather(gpusort);
toc
%}