function [Xks] = newton_raphson(x0, F, dF, ddF, tol, maxit)
    Xks = zeros(1, maxit + 1);
    Xks(1) = x0;


    for k = 1:maxit
        
        xk   = Xks(k);
        Fk   = F(xk);
        dFk  = dF(xk);
        ddFk = ddF(xk);
        
        % Compute the Newton–Raphson step
        sk = - (dFk * dFk + Fk * ddFk) \ (dFk * Fk);
      
        % Check convergence based on step magnitude
        if abs(sk) < tol
            Xks(k + 1) = xk + sk;
            Xks(k + 2:end) = [];  % Trim unused preallocated space
            return
        end

        Xks(k + 1) = xk + sk;
    end

end
