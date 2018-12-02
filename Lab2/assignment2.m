format long g;
data=load('wdbc2.dat');
f_count=30;
x=data(:,3:32);
y=data(:,2);
ma = {'ko','ks'};
fc = {[0 0 0],[1 1 1]};
tv = unique(y)
figure(1); hold off
for i = 1:length(tv)
    pos = find(y==tv(i));
    plot(x,ma{i},'markerfacecolor',fc{i});
    hold on
end

