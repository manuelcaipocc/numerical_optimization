clear
close all
clc


% define function f2
f2 = @(x,y) 1+(x.^2+y.^2)/4000-cos(x).*cos(y/sqrt(2));

% set basic setting
pmax = 10;
num_part = 30;
num_searches = 10;

% set plots
figure('Position', [100,100,1000,700]);
[x,y] = meshgrid(-pmax:0.01:pmax,-pmax:0.01:pmax);
z = f2(x,y);
contour(x,y,z);
hold on;
shading interp;
colormap(turbo(256));
xlim([-pmax,pmax]);
ylim([-pmax,pmax]);
xlabel('x', 'Interpreter', 'latex');
ylabel('y', 'Interpreter', 'latex');
t_plot = title('Iteration step: 0, global best: $$\infty$$', 'Run: 1', 'Interpreter', 'latex', 'FontSize', 18);
p_plot = plot(2*pmax, 2*pmax, '.', 'MarkerSize',20);
v_plot = quiver(2*pmax, 2*pmax, 0, 0, 0, 'Color', 'red', 'LineWidth', 2, 'MaxHeadSize', 0.5);
g_plot = plot(2*pmax,2*pmax,'x','Color',[0 0.6 0],'MarkerSize',20,'LineWidth',2);    
plot(2*pmax,2*pmax,'x','Color',[1 0.5 0],'MarkerSize',20,'LineWidth',2); 
legend('', 'Particles', 'Velocities', 'current global best', 'results of previous runs', 'Interpreter', 'latex', 'FontSize',12);
pause(5);

% perform several particle swarm optimizations
for l = 1:num_searches

    % draw random initial particles from uniform distribution over [-pmax,pmax]x[-pmax,pmax]
    p0 = (2*rand(2,num_part)-1)*pmax;
    
    % draw random initial velocities from uniform distribution over [-vmax,vmax]x[-vmax,vmax]
    vmax = 0.4*pmax;
    v0 = (2*rand(2,num_part)-1)*vmax;
    
    % set parameters for particle swarm optimization
    c_p = 1.5; % weight particle's best
    c_g = 1.5; % weight global best
    inertia = 0.7;
    max_it = 200; % max number iteration steps
    max_noupd = 20; % max number successive iteration steps without new global best

    % function for plotting iteration step's particles
    plot_it = @(p,v,g_best,k,f_best) plot_it_aux(p,v,g_best,k,f_best);

    % perform particle swarm optimization
    g_best = particle_swarm_optimization(f2, p0, v0, inertia, c_p, c_g, max_it, max_noupd,p_plot,v_plot,g_plot,t_plot,vmax);

    % plot result of optimization
    plot(g_best(1),g_best(2),'x','Color',[1 0.5 0],'MarkerSize',20,'LineWidth',2,'HandleVisibility','off');  
    if l < num_searches
        t_plot = title(get(t_plot, 'String'), ['Run ',num2str(l+1)], 'Interpreter', 'latex', 'FontSize', 18);
    end
end

% turn off plot of last run's particles
set(p_plot, 'XData', 2*pmax, 'YData', 2*pmax);
set(v_plot, 'XData', 2*pmax, 'YData', 2*pmax, 'UData', 0, 'VData', 0);
set(g_plot, 'XData', 2*pmax, 'YData', 2*pmax);

% only for plotting, not relevant
function [] = plot_it_aux(p,v,g_best,k,f_best)
    set(p_plot, 'XData', p(1,:), 'YData', p(2,:));
    set(v_plot, 'XData', p(1,:), 'YData', p(2,:), 'UData', v(1,:)/vmax, 'VData', v(2,:)/vmax);
    set(g_plot, 'XData', g_best(1), 'YData', g_best(2));
    set(t_plot, 'String', ['Iteration step: ', num2str(k), ', global best: ', num2str(f_best)]);
    pause(0.01);
end