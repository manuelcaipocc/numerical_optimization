clear
close all
clc


%% trust region method

% Himmelblau function
f = @(x) (x(1).^2+x(2)-11).^2 + (x(1)+x(2).^2-7).^2;
grad_f = @(x) [ 4*x(1).*(x(1).^2+x(2)-11) + 2*(x(1)+x(2).^2-7); 2*(x(1).^2+x(2)-11) + 4*x(2).*(x(1)+x(2).^2-7)];
H_f = @(x) [12*x(1).^2+4*x(2)-42, 4*x(1)+4*x(2); 4*x(1)+4*x(2), 12*x(2).^2+4*x(1)-26];

% parameters
x0 = rand(2,1)*8-[4;4];
tol = 10^(-5);
max_it = 10000;
eta1 = 0.25;
eta2 = 0.75;
nu1 = 0.25;
nu2 = 2;
Delta0 = 1;

% perform trust region method
[X, D] = trust_region_cauchy(f, grad_f, H_f, x0, tol, max_it, Delta0, eta1, eta2, nu1, nu2);


%% plots

sgtitle('\underline{Himmelblau function}','interpreter','latex','FontSize',17);

subplot(2,2,1);
[x,y] = meshgrid(linspace(-4,4,100), linspace(-4,4,100));
z = (x.^2+y-11).^2 + (x+y.^2-7).^2;
contour(x,y,z,200,'HandleVisibility','off');
hold on;
plot(X(1,:), X(2,:), '.--r');
title('Iteration sequence','interpreter','latex','FontSize',15);

subplot(2,2,2);
norm_grad = zeros(size(X,2),1);
for i = 1:length(norm_grad)
    norm_grad(i) = norm(grad_f(X(:,i)));
end
semilogy(0:size(X,2)-1,norm_grad,'--x');
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$\|\nabla f(x_k)\|_2$$', 'interpreter','latex','FontSize',13);
title('Norm of gradient','interpreter','latex','FontSize',15);

subplot(2,2,3);
plot(0:length(D)-1,log(D)/log(2),'--x');
ylim([-0.2+min(log(D)/log(2)),0.2+max(log(D)/log(2))]);
yticks(-20:20);
xlabel('$$k$$-th iteration step', 'interpreter','latex','FontSize',13);
ylabel('$$t_k$$ s.t. trust region radius $$\Delta_k=2^{t_k}$$', 'interpreter','latex','FontSize',13);
title('Trust region radius','interpreter','latex','FontSize',15);