function[X] = descent_method(x0, grad_f, direction, step_size, max_it, tol)

x = x0;
X = [x];
k = 0;

% terminate if gradient close to zero or max number of iteration steps reached
while norm(grad_f(x)) > tol && k < max_it

    % determine search direction
    d = direction(x);

    % determine step size
    alpha = step_size(x, d);
     
    % compute next iterate
    x = x + alpha * d;

    X = [X,x];
    k = k+1;

end

end