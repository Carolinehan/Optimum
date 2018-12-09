 c=[10 0 20 11 12 7 9 20 0 14 16 18];
s=3;
d=4;

f=c

% Aeq=zeros(7,12);
% for i=1:s
%     for j=1:d
%         Aeq(i,((i-1)*4)+j)=1;
%     end
% end
% 
% for j=1:d
%     for i=1:s
%         Aeq(j+s,((i-1)*4)+j)=1;
%     end
% end
% Beq=[25 55 35 15 45 30 25];
% A=-eye(12,12);
% b=zeros(1,12);
% 
% interior_options = optimoptions('linprog','Algorithm','interior-point','Display','iter');
% x_interior=linprog(f,A,b,Aeq,Beq,[],[],interior_options)
% simplex_options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
% x_simplex=linprog(f,A,b,Aeq,Beq,[],[],simplex_options)


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
simplex_options = optimoptions('linprog','Algorithm','dual-simplex','Display','iter');
x_simplex=linprog(f,A_2,b_2,Aeq_2,Beq_2,[],[],simplex_options)




