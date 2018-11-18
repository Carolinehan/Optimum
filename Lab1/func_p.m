% function [Fx, GrFx, Jacobian] = func_p(func,t,x,y)   
%     Fx =feval(func,x,t)-y
%     syms x_t t_t y_t;
%     fx = feval(func,x,t_t)-y_t
%     gr = gradient(fx,x)
%     GrFx = gr(t)
%     Jacobian = GrFx'
% end

function [x,resnorm,residual] = levmarq(func,x0)
    x = x0(:);
    lx = length(x);
    fx = feval(func, x);
    
end

function fh = func(x) 
t = [0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0];
y = [6.8 3.0 1.5 0.75 0.48 0.25 0.20 0.15];
fh = (x(1)*(exp(x(2)*t))-y);
fh.fx = fh(x, t,y);
syms x_t t_t y_t;
gr = gradient(fh(x_t,t_t,y_t), x);
fh.gr = subs(gr,x_t,x);
end