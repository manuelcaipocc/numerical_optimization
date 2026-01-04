clear
close all
clc


% Rosenbrock function
f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2;
grad_f = @(x) [ -2*(1 - x(1)) - 400*x(1)*(x(2) - x(1)^2); 200*(x(2) - x(1)^2) ];

% parameters non-linear cg-method
x0 = rand(2,1)*6-[3;2];
tol = 10^(-4);
max_it = 100000;

% parameters Armijo condition
beta = 0.5;
sigma = 10^(-4);

% function handle for determination of Armijo step size
step_size = @(x,d) armijo_step_size(x, d, f, grad_f, beta, sigma);

% function handles for determination of search directions (for all three variants of non-linear cg)
direction_cg_FR = @direction_FR;
direction_cg_PR = @direction_PR;
direction_cg_HS = @direction_HS;


% execution of non-linear cg-method in all three variants
X_FR = nonlin_cg(x0, grad_f, direction_cg_FR, step_size, max_it, tol);
X_PR = nonlin_cg(x0, grad_f, direction_cg_PR, step_size, max_it, tol);
X_HS = nonlin_cg(x0, grad_f, direction_cg_HS, step_size, max_it, tol);

% determine approximation errors
err_FR = zeros(size(X_FR,2),1);
err_PR = zeros(size(X_PR,2),1);
err_HS = zeros(size(X_HS,2),1);
for i = 1:size(X_FR,2)
    err_FR(i) = norm(X_FR(:,i)-[1;1]);
end
for i = 1:size(X_PR,2)
    err_PR(i) = norm(X_PR(:,i)-[1;1]);
end
for i = 1:size(X_HS,2)
    err_HS(i) = norm(X_HS(:,i)-[1;1]);
end

% plots
[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z = (1-x).^2 + 100*(y-x.^2).^2; 
subplot(2,2,1);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Fletcher-Reeves}','Interpreter','latex','FontSize',15);
plot(X_FR(1,:), X_FR(2,:), '.--r');
subplot(2,2,2);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Polak-Rebiere}','Interpreter','latex','FontSize',15);
plot(X_PR(1,:), X_PR(2,:), '.--r');
subplot(2,2,3);
contour(x,y,z,200,'HandleVisibility','off');
hold on;
title('\underline{Hestenes-Stiefel}','Interpreter','latex','FontSize',15);
plot(X_HS(1,:), X_HS(2,:), '.--r');
subplot(2,2,4);
title('Errors','Interpreter','latex','FontSize',15);
loglog(1:size(X_FR,2), err_FR, 'x--b');
hold on;
loglog(1:size(X_PR,2), err_PR, 'x--r');
loglog(1:size(X_HS,2), err_HS, 'x--','Color',[0 0.5 0]);
legend('FR', 'PR', 'HS','Location','southwest');
xlabel('number of iterations', 'interpreter', 'latex','FontSize',13);
ylabel('$$\|x_k-x^\star\|_2$$', 'interpreter', 'latex','FontSize',13);
sgtitle('\underline{Rosenbrock function}','Interpreter','latex','FontSize',18);

function d_new = direction_FR(grad_curr, grad_old, d_old)
    denom = grad_old' * grad_old;
    if denom == 0
        beta = 0;
    else
        beta = (grad_curr' * grad_curr) / denom;
    end
    d_new = -grad_curr + beta * d_old;
end

function d_new = direction_PR(grad_curr, grad_old, d_old)
    diff  = grad_curr - grad_old;
    denom = grad_old' * grad_old;
    if denom == 0
        beta = 0;
    else
        beta = (grad_curr' * diff) / denom;
    end
    d_new = -grad_curr + beta * d_old;
end

function d_new = direction_HS(grad_curr, grad_old, d_old)
    diff  = grad_curr - grad_old;
    denom = d_old' * diff;
    if denom == 0
        beta = 0;
    else
        beta = (grad_curr' * diff) / denom;
    end
    d_new = -grad_curr + beta * d_old;
end