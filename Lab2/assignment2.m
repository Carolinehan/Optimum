format long g;
data=load('wdbc2.dat');
f_count=30;
x=data(1:500,3:32);
y=data(1:500,2);
n = size(x,1); %row numbers
m = size(x,2); % column numbers
c=1000;
stop=0;
H = diag([ones(1, m), zeros(1, n + 1)]);
p = diag(y) * x;
A = -[p y eye(n);zeros(n,m) zeros(n,1),eye(n)];
B = -[ones(n,1);zeros(n,1)];
%lb = [-inf * ones(m+1,1) ;zeros(n,1)];
min=0;



f_result=-1;
f_w=0;
f_b=0;
f_eps=0;
f_c=c;
r=[];
x_c=[];

for i=0:999
    c= 1000-i
    f = [zeros(1,m+1) c*ones(1,n)]';
    options = optimoptions('quadprog','Display','Off','MaxIterations',20);
    z = quadprog(H,f,A,B,[],[],[],[],[],options);
    w = z(1:m,:);
    b = z(m+1,:);
    eps = z(m+2:m+n+1,:);
    result = (1/2)*(w'*w)+c*sum(eps,'all');
    r=[r;result];
    x_c=[x_c;c];
    if f_result==-1 || f_result > result
        f_result=result;
        f_w=w;
        f_b=b;
        f_eps=eps;
        f_c = c;
    end
    
end

plot(x_c,r);

acc_count=0;
sense_count=0;
spec_count=0;
for t=501:569
   r = f_w'*(data(t,3:32))'+f_b;
   if r >1
       y = 1;
       sense_count = sense_count+1;
   elseif r<-1
       y = -1;
       spec_count =spec_count+1;
   end
   if y==data(t,2)
       acc_count = acc_count+1;
   end
end
acc = acc_count/69
sense= sense_count/69
spec=spec_count/69
f_w
f_b
f_eps
f_c
f_result



