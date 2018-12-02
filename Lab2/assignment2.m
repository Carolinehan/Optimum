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
A = -[p y eye(n)];
B = -ones(n,1);
lb = [-inf * ones(m+1,1) ;zeros(n,1)];
min=0;

f_result=0;
f_w=0;
f_b=0;
f_eps=0;
while stop==0    
    f = [zeros(1,m+1) c*ones(1,n)]';
    z = quadprog(H,f,A,B,[],[],lb);
    w = z(1:m,:);
    b = z(m+1:m+1,:);
    eps = z(m+2:m+n+1,:);
    result = (1/2)*(w'*w)+c*sum(eps,'all');
    
    c=c-1;
    if c==0
        stop = 1;
    end
    
    acc_count = 0;
    sense_count=0;
    spec_count=0;
    high_acc=0;
    f_sense=0;
    f_spec=0;
    for i=501:569
        
       r = w'*(data(i,3:32))'+b;
       if r >0
           y = 1;
           sense_count = sense_count+1;
       else
           y = -1;
           spec_count =spec_count+1;
       end
       
       if y==data(i,2)
           acc_count = acc_count+1;
       end
    end
    
    acc = acc_count/69
    sense= sense_count/69;
    spec=spec_count/69;
    
    
    if high_acc==0 || high_acc < acc
        high_acc = acc;
        f_sense = sense;
        f_spec = spec;
        f_result=result;
        f_w=w;
        f_b=b;
        f_eps=eps;
    end
    
    if acc_count == 69
        stop = 1;
    end
   
end

x=high_acc


