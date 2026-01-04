%% Exercise g): Feasible sets and objective visualization (single large figure)
% Objective function:
%   f(x) = (x1 - 2)^2 + x2^2
%
% Constraints:
%   g1(x) = (x1 - 1)^3 + x2 <= 0   <=>  x2 <= -(x1 - 1)^3
%   g2(x) = -x2 <= 0               <=>  x2 >= 0
%   g3(x) = x1 - 1 <= 0            <=>  x1 <= 1

clear; close all; clc;

%% -------------------------------------------------------
% Visualization domain (chosen large enough to see geometry clearly)
x1_min = -6;  x1_max = 6;
x2_min = -6;  x2_max = 6;

N = 800;
x1 = linspace(x1_min, x1_max, N);
x2 = linspace(x2_min, x2_max, N);
[X1, X2] = meshgrid(x1, x2);

%% -------------------------------------------------------
% Evaluate constraints on the grid
g1 = (X1 - 1).^3 + X2;
g2 = -X2;
g3 = X1 - 1;

% Feasible sets
feasible6 = (g1 <= 0) & (g2 <= 0);
feasible7 = (g1 <= 0) & (g2 <= 0) & (g3 <= 0);

%% -------------------------------------------------------
% Boundary curves (constraints = 0)
x2_g1 = -(x1 - 1).^3;        % g1(x) = 0
x2_g2 = zeros(size(x1));     % g2(x) = 0
x1_g3 = ones(size(x2));      % g3(x) = 0

%% -------------------------------------------------------
% Objective function
f = (X1 - 2).^2 + X2.^2;

%% Known minimizer (for both problems)
x_star = [1, 0];

%% -------------------------------------------------------
% Create one large figure with subplots
figure('Units','normalized','Position',[0.03 0.05 0.94 0.85]);

%% =======================================================
% Subplot 1: Feasible set of Problem (6)
subplot(1,3,1);
imagesc(x1, x2, feasible6); axis xy; axis  tight;
colormap([1 1 1; 1 0.85 0.85]); % white = infeasible, red = feasible
hold on;

plot(x1, x2_g1, 'b-', 'LineWidth', 2);   % g1(x) = 0
plot(x1, x2_g2, 'k-', 'LineWidth', 2);   % g2(x) = 0
plot(x_star(1), x_star(2), 'ro', 'MarkerFaceColor','r', 'MarkerSize',7);
xlim([0.4 1.6]);
ylim([-0.5 2]);

title('Problem (6): Feasible set');
xlabel('x_1'); ylabel('x_2');
legend({ ...
    'Feasible region', ...
    'g_1(x) = (x_1-1)^3 + x_2 = 0', ...
    'g_2(x) = -x_2 = 0', ...
    'Minimizer x^* = (1,0)'}, ...
    'Location','northwest');
grid on; box on;

%% =======================================================
% Subplot 2: Feasible set of Problem (7)
subplot(1,3,2);
imagesc(x1, x2, feasible7); axis xy; axis  tight;
colormap([1 1 1; 1 0.85 0.85]);
hold on;

plot(x1, x2_g1, 'b-', 'LineWidth', 2);   % g1(x) = 0
plot(x1, x2_g2, 'k-', 'LineWidth', 2);   % g2(x) = 0
plot(x1_g3, x2, 'm-', 'LineWidth', 2);   % g3(x) = 0
plot(x_star(1), x_star(2), 'ro', 'MarkerFaceColor','r', 'MarkerSize',7);
xlim([0.4 1.6]);
ylim([-0.5 2]);

title('Problem (7): Feasible set');
xlabel('x_1'); ylabel('x_2');
legend({ ...
    'Feasible region', ...
    'g_1(x) = (x_1-1)^3 + x_2 = 0', ...
    'g_2(x) = -x_2 = 0', ...
    'g_3(x) = x_1 - 1 = 0', ...
    'Minimizer x^* = (1,0)'}, ...
    'Location','northwest');
grid on; box on;

%% =======================================================
% Subplot 3: Objective function and feasible boundary
subplot(1,3,3);
contour(X1, X2, f, 30, 'LineWidth',1.1);
hold on;

plot(x1, x2_g1, 'b-', 'LineWidth', 2);
plot(x1, x2_g2, 'k-', 'LineWidth', 2);
plot(x_star(1), x_star(2), 'ro', 'MarkerFaceColor','r', 'MarkerSize',7);
xlim([0.5 1.5]);
ylim([-0.5 0.5]);



axis  tight;
title('Objective f(x) and active constraints');
xlabel('x_1'); ylabel('x_2');
legend({ ...
    'Level sets of f(x) = (x_1-2)^2 + x_2^2', ...
    'g_1(x) = 0', ...
    'g_2(x) = 0', ...
    'Minimizer x^*'}, ...
    'Location','northwest');
grid on; box on;
