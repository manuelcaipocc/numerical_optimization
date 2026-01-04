function[X] = nonlin_cg(x0, grad_f, direction, step_size, max_it, tol)

x = x0;
X = [x0];
k = 0;

% first search direction is negative gradient
grad_f_curr = grad_f(x);
d = -grad_f_curr;

% iterate until convergence or maximum number of iteration steps
while norm(grad_f_curr) > tol && k < max_it

    % determine step size
    alpha = step_size(x, d);
    
    % compute new iterate
    x = x + alpha * d;
    X = [X,x];

    % determine new search direction
    grad_f_old = grad_f_curr;
    grad_f_curr = grad_f(x);
    d = direction(grad_f_curr, grad_f_old, d);

    k = k+1;

end