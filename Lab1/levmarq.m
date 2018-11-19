function [x,resnorm,residual] = levmarq(func,x0)
    x = x0;
    lx = length(x);
    stop = 0;
    lamda = 0.01;
    [Fx,GrFx] = feval(func, x);
    fx =double(Fx'*Fx);
    I = eye(lx);
    steps = 0;
    lc = 0.75;
    Rlo = 0.25; 
    Rhi = 0.75;
    resnorm = [];
    while stop == 0   
        steps = steps+1;
        if fx<1e-4 || steps > 100
            stop =1;
        end
        first = GrFx*Fx;
        right = -double(first);
        second = GrFx*GrFx';
        left = double(second+lamda*I);
        p= left\right;
        p=p';
        next = x+p;
        [est_Fx,est_GrFx] = feval(func, next);
        estimate_fx =double(est_Fx'*est_Fx);
        
        dS =double(p*(2*first-second*p'));
        
        d = (estimate_fx - fx)/dS;
        if d > Rhi
            lamda = lamda/2;
            if lamda < lc
                lamda=0;
            end
        elseif d < Rlo
             nu = double((estimate_fx - fx)/(p*first)+2);
            if nu<2
                nu = 2;
            elseif nu>10
                nu = 10;
            end
            if lamda==0
                lc =double(1/max(abs(diag(inv(second)))));
                lamda  = lc;
                nu = nu/2;
            end
            lamda = nu*lamda;
        end
        if(estimate_fx < fx)
           x =next; 
           resnorm =[resnorm;norm(est_Fx)];
           residual =est_Fx;
           Fx=est_Fx;
           GrFx=est_GrFx;
           fx = estimate_fx
        end
    end
    plot(resnorm);
end

