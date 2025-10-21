function X = gauss_newton(x0, F, dF, tol, maxit)
% GAUSS_NEWTON  Nonlinear least-squares via Gauss–Newton.

z = x0(:);
X = z;

    for k = 1:maxit
        r = F(z);          % m×1
        J = dF(z);         % m×n

        % step Gauss–Newton: J*s ≈ -r  (LS); avoid (J'*J)
        %s = - J \ r;
        s = - (J' * J) \ (J' * r);
        znew = z + s;
        X(:,end+1) = znew;

        if norm(s) <= tol * (1 + norm(znew))
            break;
        end
        z = znew;
    end
end
