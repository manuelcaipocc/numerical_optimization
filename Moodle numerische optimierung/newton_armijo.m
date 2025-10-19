function [x, iter] = newton_armijo(f, gradf, Hessf, ...
                                   x0, ...
                                   maxIter, tol, ...
                                   alpha0, c1, delta_min, delta_max, ...
                                   maxIter_stepsize, plot_flag)
% NEWTONSMETHOD: Rewritten such that the minimization problem
%                       f(x) -> min 
%                is solved
%
% Inputs:
%   f        - Handle to the function f(x) -> min 
%   gradf    - Handle to the gradient of f (nx1 vector)
%   Hessf    - Handle to the Hessian matrix H(x) (nxn matrix)
%   x0       - Initial guess for the solution (nx1 vector)
%   maxIter  - Maximum number of iterations (default 100)
%   tol      - Tolerance for convergence (default 1e-6)
%  Armijo step size control input:
%   alpha0   - Initial step size
%
% Outputs:
%   x        - Solution vector for all iterations
%   iter     - Number of iterations

% Initialize variables
x = x0;

for iter = 1:maxIter
    % Evaluate function and Jacobian at the current x
    Fx = gradf(x(:,iter));   % Function value (n x 1)
    Jx = Hessf(x(:,iter));   % Jacobian matrix (n x n)

    % Solve for the Newton step: J(x) * dx = -F(x)
    dx = -Jx \ Fx;

    % get stepsize such that armijo is fulfilled
    alpha = armijo_step_size(f, gradf, x(:,iter), dx, alpha0, c1, ...
                             delta_min, delta_max, maxIter_stepsize, plot_flag);

    % Update the solution
    x(:,iter+1) = x(:,iter) + alpha*dx;

    % Check for convergence
    if norm(Fx,2) < tol
        fprintf('Newton''s method converged in %d iterations.\n', iter);
        break;
    end
end

% Display warning if max iterations are reached
if iter == maxIter
    warning(['Newton''s method did not converge within the maximum' ...
             ' number of iterations.']);
end

end
