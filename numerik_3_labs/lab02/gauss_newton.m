function[X] = gauss_newton(x0, F, dF, tol, maxit)

k = 0;
x = x0;
X = [x0];

% iterate until maxit iteration steps done
while k < maxit

    % compute F(x) and dF(x)
    Fk = F(x);
    dFk = dF(x);
    
    % compute Newton correction
    s = (dFk'*dFk) \ (-dFk'*Fk);

    % terminate if ||s_k||_2 < tol
    if norm(s,2) < tol
        return;
    end

    % Newton correction
    x = x + s;

    X = [X, x];
    k = k+1;
    
end

end