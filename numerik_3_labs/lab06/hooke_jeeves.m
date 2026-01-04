function xk = hooke_jeeves(f, x0, h0, eps)
% HOOKE_JEEVES  Hooke–Jeeves method (local optimization)
%
%   xk = hooke_jeeves(f, x0, h0, eps, max_it)
%
%   f      : handle to objective function f:R^n -> R
%   x0     : initial column vector
%   h0     : initial step size(s); can be scalar or vector
%   eps    : tolerance for ||h||_1
%   max_it : maximum number of iterations (pattern moves)
%
%   xk     : approximation of local minimizer
    max_it = 1000;

    % ensure column vectors
    xk = x0(:);
    n  = numel(xk);

    % step vector h (if scalar is given, copy it to all coordinates)
    if numel(h0) == 1
        h = h0 * ones(n,1);
    else
        h = h0(:);
    end

    k = 0;

    % main loop: Algorithm 2
    while norm(h,1) > eps && k < max_it

        % y^(k) <- EXPLORATION(f, x^(k), h)
        yk = exploration(f, xk, h);

        % if y^(k) == x^(k)   (no improvement in exploration)
        if all(yk == xk)
            % h <- 1/2 h
            h = 0.5 * h;
        else
            % w^(k) <- 2 y^(k) - x^(k)
            wk = 2*yk - xk;

            % z^(k) <- EXPLORATION(f, w^(k), h)
            zk = exploration(f, wk, h);

            % if f(z^(k)) < f(y^(k)) then x^(k+1) <- z^(k)
            if f(zk) < f(yk)
                xk = zk;
            else
                % else x^(k+1) <- y^(k)
                xk = yk;
            end
        end

        k = k + 1;
    end
end


%-------------------------------------------------------------
% Subfunction: Algorithm 3 (Exploration procedure)
%-------------------------------------------------------------
function x = exploration(f, x, h)
%   f : function handle
%   x : current point (column)
%   h : vector of step sizes

    n = numel(x);

    for j = 1:n
        % try x + h_j e_j
        x_trial = x;
        x_trial(j) = x(j) + h(j);

        if f(x_trial) < f(x)
            x = x_trial;
        else
            % if no improvement, try x - h_j e_j
            x_trial(j) = x(j) - h(j);
            if f(x_trial) < f(x)
                x = x_trial;
            end
        end
    end
end
