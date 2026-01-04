function X = descent_method(x0, grad_f, direction, step_size, max_it, tol)
% DESCENT_METHOD  General implementation of a descent method
%
%   X = descent_method(x0, grad_f, direction, step_size, max_it, tol)
%
% INPUT:
%   x0         : initial point (column vector, usually dimension 2)
%   grad_f     : function handle for the gradient, grad_f(x)
%   direction  : function handle for the search direction, direction(x)
%   step_size  : function handle for the step size, step_size(x,d)
%   max_it     : maximum number of iterations
%   tol        : tolerance for ||grad_f(x)|| (stopping condition)
%
% OUTPUT:
%   X          : matrix where each column is an iterate x_k

    % initialize with starting point
    x = x0;
    X = x0;   % store the first point

    for k = 1:max_it
        g = grad_f(x);          % compute gradient at the current point

        % stopping condition: gradient is small enough
        if norm(g) < tol
            break;
        end

        % 1) compute the search direction d_k
        d = direction(x);

        % 2) compute the step size alpha_k
        alpha = step_size(x, d);

        % 3) update the point
        x = x + alpha * d;

        % store the new iterate
        X(:, end+1) = x;
    end
end
