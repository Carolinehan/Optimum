function [x,resnorm,residual] = levmarq(func,x0)
    x = x0;
    lx = length(x);
    
    stop = 0
    while stop == 0
        [Fx,GrFx] = feval(func, x);
        gama = 5
        
        error =double(Fx'*Fx);
        if error < 1e-4
            break
        end

        m = length(Fx);
        I = eye(lx);
        
        first = -double((GrFx*Fx))
        second =double(GrFx*GrFx'+gama*I)
        p= first\second;
        yy = second*p'
        x =x+p;
        resnorm =0;
        residual =0;
    end
end

