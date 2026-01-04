clear
close all
clc


%% trust region method

% Rosenbrock function
f = @(x) (1 - x(1)).^2 + 100*(x(2) - x(1).^2).^2;
grad_f = @(x) [ -2*(1 - x(1)) - 400*x(1)*(x(2) - x(1)^2); 200*(x(2) - x(1)^2) ];
H_f = @(x) [ 2 - 400*(x(2) - 3*x(1)^2), -400*x(1); -400*x(1), 200 ];

% parameters
x0 = rand(2,1)*6-[3;2];
tol = 10^(-5);
max_it = 100000;
eta1 = 0.25;
eta2 = 0.75;
nu1 = 0.25;
nu2 = 2;
Delta0 = 1;

% perform trust region method
[X, D] = trust_region_cauchy(f, grad_f, H_f, x0, tol, max_it, Delta0, eta1, eta2, nu1, nu2);


%% plots

sgtitle('\underline{Rosenbrock function}','interpreter','latex','FontSize',17);

subplot(2,3,1);
[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z = (1-x).^2 + 100*(y-x.^2).^2; 
contour(x,y,z,200,'HandleVisibility','off');
hold on;
plot(X(1,:), X(2,:), '.--r');
title('Iteration sequence','interpreter','latex','FontSize',15);

subplot(2,3,2);
err = zeros(size(X,2),1);
for i = 1:length(err)
    err(i) = norm([1;1]-X(:,i));
end
semilogy(0:size(X,2)-1,err);
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$\|x_k-x^\star\|_2$$', 'interpreter','latex','FontSize',13);
title('Error','interpreter','latex','FontSize',15);

subplot(2,3,3);
norm_grad = zeros(size(X,2),1);
for i = 1:length(norm_grad)
    norm_grad(i) = norm(grad_f(X(:,i)));
end
semilogy(0:size(X,2)-1,norm_grad);
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$\|\nabla f(x_k)\|_2$$', 'interpreter','latex','FontSize',13);
title('Norm of gradient','interpreter','latex','FontSize',15);

subplot(2,3,4);
plot(0:length(D)-1,log(D)/log(2));
ylim([-0.2+min(log(D)/log(2)),0.2+max(log(D)/log(2))]);
yticks(-20:20);
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$t_k$$ s.t. trust region radius $$\Delta_k = 2^{t_k}$$', 'interpreter','latex','FontSize',13);
title('Trust region radius','interpreter','latex','FontSize',15);

subplot(2,3,5);
plot(0:min(1001,size(X,2))-1, log(D(1:min(1001,size(X,2))))/log(2));
ylim([-0.2+min(log(D(1:min(1001,size(X,2))))/log(2)),0.2+max(log(D(1:min(1001,size(X,2))))/log(2))]);
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$t_k$$ s.t. trust region radius $$\Delta_k=2^{t_k}$$', 'interpreter','latex','FontSize',13);
title('Trust region radii of first (up to) 1000 iteration steps','interpreter','latex','FontSize',15);