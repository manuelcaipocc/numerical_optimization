clear
close all
clc


% define function f2
f2 = @(x,y) 1+(x.^2+y.^2)/4000-cos(x).*cos(y/sqrt(2));

% set basic setting
pmax = 10;
num_part = 30;

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

% plot initial setting
figure('Position', [100,100,1000,700]);
[x,y] = meshgrid(-pmax:0.01:pmax,-pmax:0.01:pmax);
z = f2(x,y);
contour(x,y,z);
shading interp;
colormap(turbo(256));
hold on;
p_plot = plot(p0(1,:), p0(2,:), '.', 'MarkerSize',20);
v_plot = quiver(p0(1,:), p0(2,:), zeros(1,num_part), zeros(1,num_part), 0, 'Color', 'red', 'LineWidth', 2, 'MaxHeadSize', 0.5);
g_plot = plot(pmax*2,pmax*2,'x','Color',[0 0.6 0],'MarkerSize',20,'LineWidth',2);
xlim([-pmax,pmax]);
ylim([-pmax,pmax]);
xlabel('x', 'Interpreter', 'latex');
ylabel('y', 'Interpreter', 'latex');
t_plot = title('Iteration step: 0, global best: $$\infty$$', 'Interpreter', 'latex', 'FontSize', 18);
legend('', 'Particles', 'Velocities', 'current global best', 'Interpreter', 'latex', 'FontSize',12);
pause(5);

% perform particle swarm optimization
particle_swarm_optimization(f2, p0, v0, inertia, c_p, c_g, max_it, max_noupd,p_plot,v_plot,g_plot,t_plot,vmax);