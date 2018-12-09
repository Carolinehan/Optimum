f = [10 0 20 11 12 7 9 20 0 14 16 18];

Aeq = [1 1 1 1 0 0 0 0 0 0 0 0
     0 0 0 0 1 1 1 1 0 0 0 0
     0 0 0 0 0 0 0 0 1 1 1 1
     1 0 0 0 1 0 0 0 1 0 0 0
     0 1 0 0 0 1 0 0 0 1 0 0
     0 0 1 0 0 0 1 0 0 0 1 0
     0 0 0 1 0 0 0 1 0 0 0 1];
 
beq = [25 55 35 15 45 30 25];

lb = [0 0 0 0 0 0 0 0 0 0 0 0];
options1 = optimoptions('linprog','Algorithm','dual-simplex');
x1 = linprog(f, [], [], Aeq, beq, lb, [], options1)
f1 = f * x1

options2 = optimoptions('linprog','Algorithm','interior-point');
x2 = linprog(f, [], [], Aeq, beq, lb, [], options2)
f2 = f * x2

s=3;
d=4;
Aeq_2=zeros(4,4);
for j=1:d
    for i=1:s
        Aeq_2(j,((i-1)*4)+j)=1;
    end
end

A_s=zeros(3,12);
for i=1:s
    for j=1:d
        A_s(i,((i-1)*4)+j)=1;
    end
end
A=-eye(12,12);
A_2=[A; A_s ];
b=zeros(1,12);
b_2=[b 25 60 35];

Beq_2=[15 45 30 25];

interior_options = optimoptions('linprog','Algorithm','interior-point','Display','iter');
x_interior=linprog(f,A_2,b_2,Aeq_2,Beq_2,[],[],interior_options)
inter_result_4=f*x_interior
simplex_options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
x_simplex=linprog(f,A_2,b_2,Aeq_2,Beq_2,[],[],simplex_options)
simplex_result_4=f*x_simplex


