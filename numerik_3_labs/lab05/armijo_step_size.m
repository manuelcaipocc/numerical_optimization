function alpha = armijo_step_size(x, d, f, grad_f, beta, sigma)
% ARMIJO_STEP_SIZE  Armijo rule (backtracking line search)
%
%   alpha = armijo_step_size(x, d, f, grad_f, beta, sigma)
%
% INPUT:
%   x      : current point
%   d      : search direction
%   f      : function handle of the objective function, f(x)
%   grad_f : function handle for the gradient, grad_f(x)
%   beta   : reduction factor (0 < beta < 1), for example 0.5
%   sigma  : Armijo parameter (0 < sigma < 1), for example 1e-4
%
% OUTPUT:
%   alpha  : step size that satisfies the Armijo condition

    alpha = 1;                    % initial step size
    fx = f(x);                    % current function value
    gx = grad_f(x);               % current gradient
    dir_deriv = gx' * d;          % directional derivative along d

    % Armijo condition:
    % f(x + alpha*d) <= f(x) + sigma * alpha * grad_f(x)' * d
    %
    % while this condition is NOT satisfied, we keep shrinking alpha

    while f(x + alpha * d) > fx + sigma * alpha * dir_deriv
        alpha = beta * alpha;     % backtracking: alpha, beta*alpha, beta^2*alpha, ...
        
        %     break;
        % end
    end
end
