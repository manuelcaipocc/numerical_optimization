close all
clc
clear


% F and dF
F = @(x) [ 1-x(1); 10*(x(2)-x(1).^2); sqrt(x(1).^2+x(2).^2) ];
dF = @(x) [-1, 0; -20*x(1), 10; x(1)/sqrt(x(1).^2+x(2).^2), x(2)/sqrt(x(1).^2+x(2).^2)];

% two starting points
for x0 = [[-3;3], [2;4]]

    % set figure
    figure('Position', [100,100,1000,700]);
    sgtitle(['Errors and damping parameters for $$x_0=(',num2str(x0(1)),',',num2str(x0(2)),')$$'], 'Interpreter', 'latex', 'FontSize', 18);

    % apply Gauss-Newton
    X_gn = gauss_newton(x0, F, dF, 10^(-10), 100);
    
    % apply Levenberg-Marquardt
    mu0 = 0.3;
    [X_lm, Mu_lm] = levenberg_marquardt(x0, F, dF, mu0, 0.3, 0.9, 10^(-10), 100);
    
    % exact solution
    exact = zeros(2,1);
    exact(1) = 0.1 * ( (101/2*(45+sqrt(3237)))^(1/3)/3^(2/3) - 101^(2/3)*(2/3/(45+sqrt(3237)))^(1/3) );
    exact(2) = 100/101*exact(1)^2;
    
    % compute errors in euclidean 2-Norm
    numIt_gn = size(X_gn,2);
    err_gn = zeros(numIt_gn,1);
    for i = 1:numIt_gn
        err_gn(i) = norm(X_gn(:,i)-exact);
    end
    numIt_lm = size(X_lm,2);
    err_lm = zeros(numIt_lm,1);
    for i = 1:numIt_lm
        err_lm(i) = norm(X_lm(:,i)-exact);
    end
    
    % plot errors
    subplot(1,2,1);
    semilogy(0:numIt_gn-1, err_gn, '*--blue');
    hold on;
    semilogy(0:numIt_lm-1, err_lm, 'o--red');
    xlabel('k-th iteration step', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$$\|(\hat{x},\hat{y}) - (x_k,y_k)\|_2$$', 'Interpreter', 'latex', 'FontSize', 14);
    ylim([min(err_gn(end),err_lm(end))*0.5, max(err_gn(1),err_lm(1))*1.5]);
    legend('Gauss-Newton', 'Levenberg-Marquardt', 'Interpreter', 'latex', 'FontSize', 14);
    title('Error decay over iteration steps', 'Interpreter', 'latex', 'FontSize', 16);
    
    % plot damping parameters
    subplot(1,2,2);
    exp_mu = log(Mu_lm/mu0) / log(2);
    plot(0:size(Mu_lm,2)-1, exp_mu, 'o--red');
    xlabel('k-th iteration step', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$$l_k$$ with $$\mu_k = 2^{l_k} \mu_0$$', 'Interpreter', 'latex', 'FontSize', 14);
    ylim([min(exp_mu)-0.3, max(exp_mu)+0.3]);
    yticks(-10:1:10);
    title('Damping parameter LM over iteration steps', 'Interpreter', 'latex', 'FontSize', 16);

end