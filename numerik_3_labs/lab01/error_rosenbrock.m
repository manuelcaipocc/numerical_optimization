close all
clc
clear


% F and dF
F = @(x) [ 1-x(1); 10*(x(2)-x(1).^2); sqrt(x(1).^2+x(2).^2) ];
dF = @(x) [-1, 0; -20*x(1), 10; x(1)/sqrt(x(1).^2+x(2).^2), x(2)/sqrt(x(1).^2+x(2).^2)];

% apply Gauss-Newton
X = gauss_newton([-3;4], F, dF, 10^(-10), 100);

% exact solution
exact = zeros(2,1);
exact(1) = 0.1 * ( (101/2*(45+sqrt(3237)))^(1/3)/3^(2/3) - 101^(2/3)*(2/3/(45+sqrt(3237)))^(1/3) );
exact(2) = 100/101*exact(1)^2;

% compute errors in euclidean 2-Norm
numIt = size(X,2);
err = zeros(numIt,1);
for i = 1:numIt
    err(i) = norm(X(:,i)-exact);
end

% plot errors
semilogy(0:numIt-1, err, '--*');
xlabel('k-th iteration step', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$\|(\hat{x},\hat{y}) - (x_k,y_k)\|_2$$', 'Interpreter', 'latex', 'FontSize', 14);
ylim([err(end)*0.5, err(1)*1.5]);
title('Error decay over iteration steps', 'Interpreter', 'latex', 'FontSize', 18);