function [Fx, GrFx, Jacobian] = nonlinefun(func,t,y)
    sys x;    
    Fx =feval(func,x,t)-y;
    GrFx = gradient(Fx,x);
    Jacobian = GrFx';
end