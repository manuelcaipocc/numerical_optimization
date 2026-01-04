%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f                 function handle of function to be optimized
% x0                initial value
% T                 parameter for random acceptance
% loc_opt           function handle for local optimizer
% h                 maximum step size
% num_it            number of accepted steps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[X] = basin_hopping(f, x0, T, loc_opt, h, num_it)

% initial local optimization
x_loc  = loc_opt(x0);        % x_loc <- loc_opt(x0)
f_loc  = f(x_loc);  

X = [x0,x_loc];

% counter for accepted steps
i = 0;

% iterate until number of accepted steps reached
while i < num_it

    % take random step from x_loc to x_trial
    n = numel(x_loc);

    % local optimization starting from x_trial
     r = (2*rand(n,1) - 1) * h;
     x_trial = x_loc + r;

    x_trial_loc = loc_opt(x_trial);   % x_trial_loc <- loc_opt(x_trial)
    f_trial     = f(x_trial_loc);     % f_trial <- f(x_trial_loc)

    X = [X,x_trial,x_trial_loc];

    delta = f_trial - f_loc;

    % accept step if improvement in function value or wrt a probability
    if delta <= 0 || rand() < exp(-delta / T)

        % x_trial_loc is new x_loc
        x_loc = x_trial_loc;
        f_loc = f_trial;
        
        % increase counter of accepted steps
         i = i + 1;

    end
     
end

end