function [X_hist, mu_hist] = levenberg_marquardt(x0, F, dF, mu0, beta0, beta1, tol, maxit)
% LEVENBERG_MARQUARDT  Nonlinear least squares with (J'J + mu^2 I)
% Inputs:
%   x0, F, dF, mu0, beta0, beta1, tol, maxit (as in your script)
% Outputs:
%   X_hist : n x (k+1) iterates (first column = x0)
%   mu_hist: k x 1 values of mu at each ACCEPTED step

    xk = x0(:);
    n  = numel(xk);

    X_hist  = zeros(n, maxit+1);
    X_hist(:,1) = xk;
    mu_hist = zeros(maxit,1);

    mu = max(mu0,0);
    k  = 0;

    % values at xk
    Fk = F(xk);        % m x 1
    Jk = dF(xk);       % m x n
    JT = Jk.';         % n x m
    g  = JT*Fk;        % n x 1
    H  = JT*Jk;        % n x n

    for outer = 1:maxit

        % ---------- inner loop: increase mu until eps_mu > beta0 ----------
        I = eye(n);
        max_inner = 20;
        eps_mu = -Inf;
        for t = 1:max_inner
            % LM step: (J'J + mu^2 I) s = -J'F
            s = -(H + (mu^2)*I) \ g;

            % gain ratio indicator epsilon_mu
            F_lin = Fk + Jk*s;
            Fxks  = F(xk + s);

            num = norm(Fk)^2 - norm(Fxks)^2;
            den = norm(Fk)^2 - norm(F_lin)^2;
            if den <= 0
                eps_mu = -Inf;              % force mu increase
            else
                eps_mu = num / den;
            end

            if eps_mu > beta0
                break;                      % acceptable step
            else
                mu = 2*mu;                  % reject and increase damping
            end
        end
        % if still not good, proceed with calculated s and eps_mu = -Inf (very conservative)

        % ---------- rule for beta1 ----------
        if eps_mu >= beta1
            mu = mu/2;                      % very successful: reduce damping
        end

        % accept step
        xk_new = xk + s;

        % save history
        k = k + 1;
        X_hist(:,k+1) = xk_new;
        mu_hist(k)    = mu;

        % stop criterion by step size
        if norm(s,2) < tol
            break;
        end

        % update cached values at new point
        xk = xk_new;
        Fk = F(xk);
        Jk = dF(xk);
        JT = Jk.';
        g  = JT*Fk;
        H  = JT*Jk;
    end

    % trim history to actual length
    X_hist  = X_hist(:,1:k+1);
    mu_hist = mu_hist(1:k);
end