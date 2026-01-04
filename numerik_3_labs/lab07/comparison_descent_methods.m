clear
close all
clc



%% settings

% Rosenbrock function
f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2;
grad_f = @(x) [ -2*(1 - x(1)) - 400*x(1)*(x(2) - x(1)^2); 200*(x(2) - x(1)^2) ];
H_f = @(x) [ 2 - 400*(x(2) - 3*x(1)^2), -400*x(1); -400*x(1), 200 ];

% general parameters
x0 = rand(2,1)*6-[3;2];
max_it = 100000;
tol = 10^(-5);

% search directions (function handles)
dir_gradient_descent = @(x) - grad_f(x) / norm(grad_f(x));
dir_newton = @(x) - H_f(x) \ grad_f(x);
dir_cg_FR = @(grad_f_curr, grad_f_old, d_k) -grad_f_curr + grad_f_curr'*grad_f_curr / (grad_f_old'*grad_f_old) * d_k;

% Armijo step size backtracking algorithm (function handle)
beta = 0.5;
sigma = 10^(-4);
step_armijo = @(x,d) armijo_step_size(x, d, f, grad_f, beta, sigma);

% Wolfe step size zoom algorithm (function handle)
alpha_init = 1;
c1 = 10^(-4);
c2 = 0.5;
step_wolfe = @(x,d) zoom_wolfe(f, grad_f, x, d, alpha_init, c1, c2);


%% execution of descent methods

% gradient descent with Armijo step size
X_gr_ar = descent_method(x0, grad_f, dir_gradient_descent, step_armijo, max_it, tol);

% gradient descent with Wolfe step size
X_gr_wo = descent_method(x0, grad_f, dir_gradient_descent, step_wolfe, max_it, tol);

% Newton with Armijo step size
X_ne_ar = descent_method(x0, grad_f, dir_newton, step_armijo, max_it, tol);

% Newton with Wolfe step size
X_ne_wo = descent_method(x0, grad_f, dir_newton, step_wolfe, max_it, tol);

% Nonlinear cg (Fletcher-Reeves) with Armijo step size
X_cg_ar = nonlin_cg(x0, grad_f, dir_cg_FR, step_armijo, max_it, tol);

% Nonlinear cg (Fletcher-Reeves) with Wolfe step size
X_cg_wo = nonlin_cg(x0, grad_f, dir_cg_FR, step_wolfe, max_it, tol);


%% plots

[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z = (1-x).^2 + 100*(y-x.^2).^2; 

subplot(3,3,1);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Gradient descent + Armijo step size}','Interpreter','latex','FontSize',15);
subtitle(['number of iterations: ',num2str(size(X_gr_ar,2)-1)], 'interpreter','latex');
plot(X_gr_ar(1,:), X_gr_ar(2,:), '.--r');

subplot(3,3,4);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Gradient descent + Wolfe step size}','Interpreter','latex','FontSize',15);
subtitle(['number of iterations: ',num2str(size(X_gr_wo,2)-1)], 'interpreter','latex');
plot(X_gr_wo(1,:), X_gr_wo(2,:), '.--r');

subplot(3,3,2);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Newton + Armijo step size}','Interpreter','latex','FontSize',15);
subtitle(['number of iterations: ',num2str(size(X_ne_ar,2)-1)], 'interpreter','latex');
plot(X_ne_ar(1,:), X_ne_ar(2,:), '.--r');

subplot(3,3,5);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Newton + Wolfe step size}','Interpreter','latex','FontSize',15);
subtitle(['number of iterations: ',num2str(size(X_ne_wo,2)-1)], 'interpreter','latex');
plot(X_ne_wo(1,:), X_ne_wo(2,:), '.--r');

subplot(3,3,3);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Nonlinear cg + Armijo step size}','Interpreter','latex','FontSize',15);
subtitle(['number of iterations: ',num2str(size(X_cg_ar,2)-1)], 'interpreter','latex');
plot(X_cg_ar(1,:), X_cg_ar(2,:), '.--r');

subplot(3,3,6);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Nonlinear cg + Wolfe step size}','Interpreter','latex','FontSize',15);
subtitle(['number of iterations: ',num2str(size(X_cg_wo,2)-1)], 'interpreter','latex');
plot(X_cg_wo(1,:), X_cg_wo(2,:), '.--r');

subplot(3,3,7);
err_gr_ar = vecnorm(X_gr_ar-[1;1]);
err_gr_wo = vecnorm(X_gr_wo-[1;1]);
err_ne_ar = vecnorm(X_ne_ar-[1;1]);
err_ne_wo = vecnorm(X_ne_wo-[1;1]);
err_cg_ar = vecnorm(X_cg_ar-[1;1]);
err_cg_wo = vecnorm(X_cg_wo-[1;1]);
loglog(0:length(err_gr_ar)-1,err_gr_ar,'--r');
hold on;
loglog(0:length(err_gr_wo)-1,err_gr_wo,':r','LineWidth',1);
loglog(0:length(err_ne_ar)-1,err_ne_ar,'--b');
loglog(0:length(err_ne_wo)-1,err_ne_wo,':b','LineWidth',1);
loglog(0:length(err_cg_ar)-1,err_cg_ar,'--','Color',[0 0.5 0]);
loglog(0:length(err_cg_wo)-1,err_cg_wo,':','Color',[0 0.5 0],'LineWidth',1);
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$\|x_k - x^\star\|_2$$','interpreter','latex','FontSize',13);
ylim([10^(-5),1.1*max([max(err_gr_ar),max(err_gr_wo),max(err_ne_ar),max(err_ne_wo),max(err_cg_ar),max(err_cg_wo)])]);
xlim([0,1.1*max([length(err_gr_ar),length(err_gr_wo),length(err_ne_ar),length(err_ne_wo),length(err_cg_ar),length(err_cg_wo)])]);
loglog(1,10^8,'--','Color','black');
loglog(1,10^8,':','Color','black');
loglog(1,10^8,'r');
loglog(1,10^8,'b');
loglog(1,10^8,'Color',[0 0.5 0]);
legend('','','','','','','Armijo step size','Wolfe step size','Gradient descent','Newton', 'Nonlinear cg','interpreter','latex','FontSize',11,'Location','northeastoutside');
title('\underline{Error}','Interpreter','latex','FontSize',15);

sgtitle('\underline{Rosenbrock function}','interpreter','latex','FontSize',17);