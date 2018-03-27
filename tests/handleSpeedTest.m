clear
clc

test = rand(10000);
wrapped = ArrayWrapper(test);

tic
handleTest(wrapped);
toc
tic
test = nonHandleTest(test);
toc

all(all(test == wrapped.data))