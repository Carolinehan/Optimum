
rng default % for reproducibility
t = [0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0];
y = [6.8 3.0 1.5 0.75 0.48 0.25 0.20 0.15];

fun = @(x)x(1)*(exp(x(2)*t))-y;
x0 = [1 2];
options = optimoptions('lsqnonlin','Display','iter');
options.Algorithm = 'levenberg-marquardt';
[x,resnorm,residual,exitflag,output] = lsqnonlin(fun,x0,[],[],options);
plot(t,y,'ko');
hold on
tlist = linspace(t(1),t(end));
plot(tlist,x(1)*(exp(x(2)*tlist)),'b-');
xlabel t
ylabel y
title('Exponential Fit to Data')
legend('Data','Exponential Fit')
hold off
output