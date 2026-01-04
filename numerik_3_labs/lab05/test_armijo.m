%% Wolfe conditions: Armijo + curvature demo
clear; clc; close all;

%% Function and derivative
f  = @(x) 0.5 * x.^2;
df = @(x) x;

%% Starting point
xk = 2.5;
gk = df(xk);
dk = -gk;

%% Alpha grid
alphas = linspace(0, 2, 400);
phi    = f(xk + alphas*dk);
dphi   = df(xk + alphas*dk) .* dk;   % directional derivative

%% Parameters
c1 = 1e-2;
c2 = 0.9;    % must be > c1

%% Armijo line
armijo_line = f(xk) + c1 * alphas * (gk * dk);

%% Armijo acceptance
armijo_ok = phi <= armijo_line;

%% Curvature acceptance
curvature_ok = dphi >= c2 * (gk * dk);

%% Wolfe (both)
wolfe_ok = armijo_ok & curvature_ok;

%% Plot phi(alpha)
figure; clf; hold on; box on; grid on;

plot(alphas, phi, 'b-', 'LineWidth', 1.5);
plot(alphas, armijo_line, 'r--', 'LineWidth', 1.5);

plot(alphas(armijo_ok), phi(armijo_ok), 'go', 'MarkerSize', 4);
plot(alphas(~armijo_ok), phi(~armijo_ok), 'rx', 'MarkerSize', 6);

% Mark curvature regions
y_min = min(phi);
y_max = max(phi);
plot(alphas(curvature_ok), y_min*ones(sum(curvature_ok),1), 'cs', 'MarkerFaceColor','c');

% Wolfe-acceptable region
plot(alphas(wolfe_ok), phi(wolfe_ok), 'mo', 'MarkerFaceColor','m','MarkerSize',6);

legend('\phi(\alpha)', 'Armijo line', ...
       'Armijo OK', 'Armijo NO', ...
       'Curvature OK (cyan markers at bottom)', ...
       'Wolfe OK (Armijo + Curvature)', ...
       'Location', 'best');

title('Wolfe Conditions Visualization');
xlabel('\alpha');
ylabel('\phi(\alpha)');
