format long g;
data=load('wdbc2.dat');
f_count=30;
x=data(:,3:32);
y=data(:,2);
n = size(x,1); %row numbers
m = size(x,2); % column numbers
c=1000;
H = diag([ones(1, m), zeros(1, n + 1)]);
f = [zeros(1,m+1) c*ones(1,n)]';
p = diag(y) * x;
A = -[p y eye(n)];
B = -ones(n,1);
lb = [-inf * ones(m+1,1) ;zeros(n,1)];
z = quadprog(H,f,A,B,[],[],lb);
w = z(1:m,:)
b = z(m+1:m+1,:)
eps = z(m+2:m+n+1,:)
