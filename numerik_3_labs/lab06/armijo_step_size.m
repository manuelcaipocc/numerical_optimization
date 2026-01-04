function[t] = armijo_step_size(x, d, f, grad_f, beta, sigma)

    % evaluate function and derivative at x
    grad_f_x = grad_f(x);
    f_x = f(x);
    
    % initial step size: beta^0 = 1
    t = 1;

    % iterate until Armijo step size found
    while f(x + t * d) > (f_x + sigma * t * grad_f_x' * d)
        
        % decrease step size with factor beta
        t = t*beta;
        
    end

end