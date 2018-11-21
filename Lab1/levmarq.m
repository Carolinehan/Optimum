function [x,resnorm,residual] = levmarq(func,x0)
    x = x0;
    lx = length(x);
    stop = 0;
    lambda = 0.01;
    [Fx,GrFx] = feval(func, x);
    fx =double(Fx'*Fx);
    I = eye(lx);
    steps = 0;
    resnorm = [];
    while stop == 0   
        steps = steps+1;
        first = GrFx*Fx;
        right = -double(first);
        second = GrFx*GrFx';
        left = double(second+lambda*I);
        p= left\right;
        p=p';
        next = x+p;
        [est_Fx,est_GrFx] = feval(func, next);
        estimate_fx =double(est_Fx'*est_Fx);
        
        if(estimate_fx < fx)
           lambda = lambda /10;
           x =next; 
           resnorm =[resnorm;norm(est_Fx)];
           residual =est_Fx;
           Fx=est_Fx;
           GrFx=est_GrFx;
           fx = estimate_fx
        else
            lambda = lambda * 10;
        end
        
        if fx<1e-4 || steps > 100
            stop =1;
        end
    end
    plot(resnorm);
end

