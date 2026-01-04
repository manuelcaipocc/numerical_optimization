%% Armijo explanation with two linked plots: f(x) and phi(alpha)
clear; clc; close all;

%% Function and derivative
f  = @(x) 0.5 * x.^2;
df = @(x) x;

%% Starting point
xk = 2.5;
gk = df(xk);
dk = -gk;           % steepest descent

%% Alpha grid for visualization
alphas = linspace(0, 2, 400);
phi    = f(xk + alphas*dk);    % phi(alpha) = f(xk + alpha*dk)

%% Armijo parameters
c1 = 1e-2;
armijo_line = f(xk) + c1 * alphas * (gk * dk);

%% Which alphas satisfy Armijo?
accepted = phi <= armijo_line;

% Choose a "typical" Armijo step: the largest alpha that still satisfies
idx_armijo = find(accepted, 1, 'last');
alpha_armijo = alphas(idx_armijo);
phi_armijo   = phi(idx_armijo);

% Theoretical optimal alpha for this specific example
alpha_opt = 1;
phi_opt   = f(xk + alpha_opt*dk);

%% Plot 1: original function f(x)
figure;
subplot(1,2,1);
hold on; box on; grid on;

x_values = linspace(-3,3,400);
plot(x_values, f(x_values), 'b-', 'LineWidth',1.5);

% Current point x_k
plot(xk, f(xk), 'ro','MarkerFaceColor','r','MarkerSize',8);

% New point using alpha_armijo
x_new_armijo = xk + alpha_armijo * dk;
plot(x_new_armijo, f(x_new_armijo), 'go','MarkerFaceColor','g','MarkerSize',8);

% New point using alpha_opt = 1 (theoretical for this example)
x_new_opt = xk + alpha_opt * dk;
plot(x_new_opt, f(x_new_opt), 'ks','MarkerFaceColor','y','MarkerSize',8);

legend('f(x)','x_k (current point)', ...
       sprintf('x_{k+1} with Armijo (\\alpha=%.2f)',alpha_armijo), ...
       sprintf('x_{k+1} optimal (\\alpha=%.2f)',alpha_opt), ...
       'Location','best');

title('Original function f(x)');
xlabel('x');
ylabel('f(x)');

% Draw arrows to visualize the movement
plot([xk, x_new_armijo],[f(xk), f(x_new_armijo)],'g--');
plot([xk, x_new_opt],[f(xk), f(x_new_opt)],'y--');

%% Plot 2: phi(alpha) and Armijo line
subplot(1,2,2);
hold on; box on; grid on;

% Curve phi(alpha)
plot(alphas, phi, 'b-', 'LineWidth',1.5);

% Armijo line
plot(alphas, armijo_line, 'r--','LineWidth',1.5);

% Accepted points (Armijo condition satisfied)
plot(alphas(accepted), phi(accepted),'go','MarkerFaceColor','g','MarkerSize',3);

% Rejected points (Armijo condition not satisfied)
plot(alphas(~accepted), phi(~accepted),'rx','MarkerSize',6,'LineWidth',1);

% Highlight alpha_armijo
plot(alpha_armijo, phi_armijo, 'ko','MarkerFaceColor','k','MarkerSize',8);
xline(alpha_armijo,'k:','LineWidth',1.2);

% Highlight alpha_opt (only to see the real minimum)
plot(alpha_opt, phi_opt, 'ms','MarkerFaceColor','m','MarkerSize',8);
xline(alpha_opt,'m:','LineWidth',1.2);

title(sprintf('\\phi(\\alpha) = f(x_k + \\alpha d_k),   x_k = %.2f', xk));
xlabel('\alpha');
ylabel('\phi(\alpha)');

legend('\phi(\alpha)', ...
       'Armijo line', ...
       'Accepted (Armijo)', ...
       'Rejected (Armijo)', ...
       sprintf('\\alpha_{Armijo} = %.2f', alpha_armijo), ...
       sprintf('\\alpha_{optimal} = %.2f', alpha_opt), ...
       'Location','best');

%% Display numerical information in console
fprintf('x_k        = %.4f\n', xk);
fprintf('g_k        = df(x_k) = %.4f\n', gk);
fprintf('d_k        = -g_k    = %.4f\n', dk);
fprintf('g_k * d_k  = %.4f  (must be < 0 for descent direction)\n', gk*dk);
fprintf('alpha_opt  = %.4f (real minimum of this phi)\n', alpha_opt);
fprintf('alpha_armijo (chosen by condition) = %.4f\n', alpha_armijo);
fprintf('f(x_k)             = %.4f\n', f(xk));
fprintf('f(x_k + alpha_armijo*d_k) = %.4f\n', f(x_new_armijo));