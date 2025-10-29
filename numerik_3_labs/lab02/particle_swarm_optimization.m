%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUTS:
% f(x,y): function to be optimized
% p0: particles' initial positions
% v0: particles' initial velocities
% inertia, c_p, c_g: parameters for velocity update 
% max_it: maximum number of iteration steps
% max_noupd: maximum number of consecutive iteration steps without new global best
% p_plot, v_plot, g_plot, t_plot, vmax: only for plotting, not relevant
% ARRAYS:
% p: (number variables x number particles)-dim. matrix with particles' current positions
% v: (number variables x number particles)-dim. matrix with particles' current velocities
% p_best: (number variables x number particles)-dim. matrix with all particles' best position so far
% g_best: (number variables)-dim. vector with global best position so far
% f_best: f(g_best)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[g_best] = particle_swarm_optimization(f, p0, v0, inertia, c_p, c_g, max_it, max_noupd, p_plot, v_plot, g_plot, t_plot, vmax)

% set initial values
p_best = p0;
g_best = [];
f_best = Inf;
p = p0;
v = v0;
k = 0;
is_upd = false;
num_noupd = 0;
num_part = size(p0,2);

% perform at most max_it iteration steps
while k < max_it

    % update g_best
    is_upd = false;
    f_pbest = arrayfun(@(j) f(p_best(1,j), p_best(2,j)), 1:num_part);
    [f_cur_best, idx_best] = min(f_pbest);
    if f_cur_best < f_best
        f_best = f_cur_best;
        g_best = p_best(:, idx_best);
        is_upd = true;
    end

    % if new global best
    if is_upd
        num_noupd = 0;   
    else % if no new global best
        num_noupd = num_noupd + 1;
        % terminate if too many iteration steps without new global best
        if num_noupd >= max_noupd
            plot_it(p, v, g_best, k, f_best, p_plot, v_plot, g_plot, t_plot, vmax);
            break;
        end
    end

    % new velocities
    r1 = rand(size(v));
    r2 = rand(size(v));
    v = inertia.*v + c_p.*r1.*(p_best - p) + c_g.*r2.*(g_best - p);

    % plot positions and velocities
    plot_it(p, v, g_best, k, f_best, p_plot, v_plot, g_plot, t_plot, vmax);

    % update positions
    p = p + v;
    
    % update all particles' personal best
    f_p = arrayfun(@(j) f(p(1,j), p(2,j)), 1:num_part);
    improve = f_p < f_pbest;
    if any(improve)
        p_best(:, improve) = p(:, improve);
        f_pbest(improve) = f_p(improve);
    end

    k = k+1;

end

end


% only for plotting, not relevant
function [] = plot_it(p, v, g_best, k, f_best, p_plot, v_plot, g_plot, t_plot, vmax)
    set(p_plot, 'XData', p(1,:), 'YData', p(2,:));
    set(v_plot, 'XData', p(1,:), 'YData', p(2,:), 'UData', v(1,:)/vmax, 'VData', v(2,:)/vmax);
    set(g_plot, 'XData', g_best(1), 'YData', g_best(2));
    set(t_plot, 'String', ['Iteration step: ', num2str(k), ', global best: ', num2str(f_best)]);
    pause(0.01);
end