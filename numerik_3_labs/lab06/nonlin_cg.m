function X = nonlin_cg(x0, grad_f, direction, step_size, max_it, tol)
% NONLIN_CG  Non-linear conjugate gradient method (Algorithm 2).


%   Input:
%     x0         : column vector with the initial guess x_0 (n x 1)
%     grad_f     : function handle for the gradient, grad_f(x)
%     direction  : function handle for the search direction update
%                  direction(grad_f_curr, grad_f_old, d_old)
%     step_size  : function handle for the step size
%                  step_size(x, d)  -> returns alpha
%     max_it     : maximum number of iterations
%     tol        : tolerance for stopping, based on ||grad f(x_k)||_2

%   Output:
%     X          : matrix (n x (number_of_iterations+1))
%                  Each column is one iterate: X(:,k+1) = x_k.
%



    x = x0(:);
    n = length(x);

    % Preallocate storage for iterates.
    % We don't know the exact number of iterations in advance,
    % but it cannot be more than max_it + 1.
    X = zeros(n, max_it + 1);
    X(:, 1) = x;  % store x_0

    % ----- Initialization 
    grad_old = grad_f(x);   % grad f_0
    d = -grad_old;          % d_0 = -grad f_0

    %  counter
    k = 0;

    while (norm(grad_old, 2) > tol) && (k < max_it)

        % 1 Step size selection (line 7)
        alpha = step_size(x, d);

        % 2 Update the iterate (line 8): x_{k+1} = x_k + alpha_k d_k
        x_new = x + alpha * d;

        % 3 Compute new gradient (line 9)
        grad_new = grad_f(x_new);

        % 4 Update search direction using the user-supplied rule
        %    (line 10–11): d_{k+1} = -grad f_{k+1} + beta_{k+1} d_k
        d = direction(grad_new, grad_old, d);

        % Increase iteration counter
        k = k + 1;

        % Store the new iterate
        X(:, k + 1) = x_new;

        % Prepare for next loop
        x = x_new;
        grad_old = grad_new;
    end

    % Trim unused columns if we stopped early (for nice output size)
    X = X(:, 1:(k + 1));
end
