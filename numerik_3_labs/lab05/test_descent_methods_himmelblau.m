clear
close all
clc


%% settings

% Himmelblau function
f = @(x) (x(1).^2+x(2)-11).^2 + (x(1)+x(2).^2-7).^2;
grad_f = @(x) [ 4*x(1).*(x(1).^2+x(2)-11) + 2*(x(1)+x(2).^2-7); 2*(x(1).^2+x(2)-11) + 4*x(2).*(x(1)+x(2).^2-7)];
hess_f = @(x) [12*x(1).^2+4*x(2)-42, 4*x(1)+4*x(2); 4*x(1)+4*x(2), 12*x(2).^2+4*x(1)-26];

% parameters
x0 = rand(2,1)*6-[3;2];
fprintf("x0 %f\n",x0);
beta = 0.5;
sigma = 10^(-4);
max_it = 100000;
tol = 10^(-5);

% search directions (function handles)
dir_gradient_descent = @(x) -grad_f(x) / norm(grad_f(x));

% Newton: dirección = - H^{-1} * gradiente  (solución del sistema lineal)
dir_newton = @(x) -hess_f(x) \ grad_f(x);

% step sizes (function handles)
step_armijo = @(x,d) armijo_step_size(x, d, f, grad_f, beta, sigma);
step_one = @(x,d) 1;


%% executions of descent methods

% gradient descent with Armijo step size
X_gr_ar = descent_method(x0, grad_f, dir_gradient_descent, step_armijo, max_it, tol);

% gradient descent with constant step size one
X_gr_one = descent_method(x0, grad_f, dir_gradient_descent, step_one, max_it, tol);

% Newton with Armijo step size
X_ne_ar = descent_method(x0, grad_f, dir_newton, step_armijo, max_it, tol);

% Newton with constant step size one
X_ne_one = descent_method(x0, grad_f, dir_newton, step_one, max_it, tol);


%% plots

[x,y] = meshgrid(linspace(-4,4,100), linspace(-4,4,100));
z = (x.^2+y-11).^2 + (x+y.^2-7).^2;

subplot(2,2,1);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Gradient descent + Armijo step size}','Interpreter','latex','FontSize',15);
if norm(grad_f(X_gr_ar(:,end))) < 0.0001
    subtitle(['number of iterations: ',num2str(size(X_gr_ar,2)-1)], 'interpreter','latex');
else
    subtitle(['number of iterations: ',num2str(size(X_gr_ar,2)-1),', not converged'], 'interpreter','latex');
end
plot(X_gr_ar(1,:), X_gr_ar(2,:), '.--r');

subplot(2,2,2);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Gradient descent + constant step size}','Interpreter','latex','FontSize',15);
if norm(grad_f(X_gr_one(:,end))) < 0.0001
    subtitle(['number of iterations: ',num2str(size(X_gr_one,2)-1)], 'interpreter','latex');
else
    subtitle(['number of iterations: ',num2str(size(X_gr_one,2)-1),', not converged'], 'interpreter','latex');
end
plot(X_gr_one(1,:), X_gr_one(2,:), '.--r');

subplot(2,2,3);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Newton + Armijo step size}','Interpreter','latex','FontSize',15);
if norm(grad_f(X_ne_ar(:,end))) < 0.0001
    subtitle(['number of iterations: ',num2str(size(X_ne_ar,2)-1)], 'interpreter','latex');
else
    subtitle(['number of iterations: ',num2str(size(X_ne_ar,2)-1),', not converged'], 'interpreter','latex');
end
plot(X_ne_ar(1,:), X_ne_ar(2,:), '.--r');

subplot(2,2,4);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Newton + constant step size}','Interpreter','latex','FontSize',15);
if norm(grad_f(X_ne_one(:,end))) < 0.0001
    subtitle(['number of iterations: ',num2str(size(X_ne_one,2)-1)], 'interpreter','latex');
else
    subtitle(['number of iterations: ',num2str(size(X_ne_one,2)-1),', not converged'], 'interpreter','latex');
end
plot(X_ne_one(1,:), X_ne_one(2,:), '.--r');

sgtitle('Himmelblau function','interpreter','latex','FontSize',17);