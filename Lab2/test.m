format long g;
data=load('wdbc2.dat');
f_count=30;
x=data(:,3:32);
y=data(:,2);
cl = fitcsvm(x,y,'KernelFunction','rbf',...
    'BoxConstraint',Inf,'ClassNames',[-1,1])