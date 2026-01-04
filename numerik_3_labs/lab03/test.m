% MATLAB Code to visualize functions and analyze their Hessians
clear all; close all; clc;

% Define range for x and y
x = linspace(-2, 2, 50);
y = linspace(-2, 2, 50);
[X, Y] = meshgrid(x, y);

%% 1. POSITIVE DEFINITE HESSIAN: f(x,y) = x^2 + y^2
f1 = X.^2 + Y.^2;

% Calculate Hessian symbolically
syms xs ys
f1_sym = xs^2 + ys^2;
H1 = hessian(f1_sym, [xs, ys]);
disp('=== POSITIVE DEFINITE HESSIAN ===');
disp('Function: f(x,y) = x² + y²');
disp('Hessian:');
disp(H1);
disp('Eigenvalues: [2, 2] - Both positive');
disp('Behavior: Strict minimum at (0,0)');

% Plot
figure('Position', [100 100 1000 700]);
subplot(2,3,1);
surf(X, Y, f1);
title('Positive Definite: x² + y²', 'FontSize', 11);
xlabel('x'); ylabel('y'); zlabel('z');
colormap(parula);
shading interp;

subplot(2,3,4);
contour(X, Y, f1, 15);
title('Contour Lines');
xlabel('x'); ylabel('y');
grid on;

%% 2. POSITIVE SEMIDEFINITE HESSIAN: f(x,y) = x^2 + y^4
f2 = X.^2 + Y.^4;

% Calculate Hessian symbolically
f2_sym = xs^2 + ys^4;
H2 = hessian(f2_sym, [xs, ys]);
disp(' ');
disp('=== POSITIVE SEMIDEFINITE HESSIAN ===');
disp('Function: f(x,y) = x² + y⁴');
disp('Hessian:');
disp(H2);
disp('At (0,0): H = [2, 0; 0, 0] - Positive semidefinite');
disp('Behavior: Non-strict minimum');

subplot(2,3,2);
surf(X, Y, f2);
title('Positive Semidefinite: x² + y⁴', 'FontSize', 11);
xlabel('x'); ylabel('y'); zlabel('z');
colormap(parula);
shading interp;

subplot(2,3,5);
contour(X, Y, f2, 15);
title('Contour Lines');
xlabel('x'); ylabel('y');
grid on;

%% 3. POSITIVE SEMIDEFINITE HESSIAN: f(x,y) = y^2 - x^4
f3 = Y.^2 - X.^4;

% Calculate Hessian symbolically
f3_sym = ys^2 - xs^4;
H3 = hessian(f3_sym, [xs, ys]);
disp(' ');
disp('=== POSITIVE SEMIDEFINITE HESSIAN (special case) ===');
disp('Function: f(x,y) = y² - x⁴');
disp('Hessian:');
disp(H3);
disp('At (0,0): H = [0, 0; 0, 2] - Positive semidefinite');
disp('Behavior: Minimum along x, but maximum in y direction');

subplot(2,3,3);
surf(X, Y, f3);
title('Positive Semidefinite: y² - x⁴', 'FontSize', 11);
xlabel('x'); ylabel('y'); zlabel('z');
colormap(parula);
shading interp;

subplot(2,3,6);
contour(X, Y, f3, 15);
title('Contour Lines');
xlabel('x'); ylabel('y');
grid on;

%% 4. INDEFINITE HESSIAN: f(x,y) = x^2 - y^2
figure('Position', [100 50 800 500]);
f4 = X.^2 - Y.^2;

% Calculate Hessian symbolically
f4_sym = xs^2 - ys^2;
H4 = hessian(f4_sym, [xs, ys]);
disp(' ');
disp('=== INDEFINITE HESSIAN ===');
disp('Function: f(x,y) = x² - y²');
disp('Hessian:');
disp(H4);
disp('Eigenvalues: [2, -2] - One positive, one negative');
disp('Behavior: Saddle point at (0,0)');

subplot(1,2,1);
surf(X, Y, f4);
title('Indefinite: x² - y² (Saddle Point)', 'FontSize', 11);
xlabel('x'); ylabel('y'); zlabel('z');
colormap(jet);
shading interp;

subplot(1,2,2);
contour(X, Y, f4, 15);
title('Contour Lines - Saddle Point');
xlabel('x'); ylabel('y');
grid on;

%% Additional eigenvalue analysis
disp(' ');
disp('=== EIGENVALUE SUMMARY ===');
fprintf('1. x² + y²: Eigenvalues = [2, 2] - POSITIVE DEFINITE\n');
fprintf('2. x² + y⁴: At (0,0) eigenvalues = [2, 0] - POSITIVE SEMIDEFINITE\n');
fprintf('3. y² - x⁴: At (0,0) eigenvalues = [2, 0] - POSITIVE SEMIDEFINITE\n');
fprintf('4. x² - y²: Eigenvalues = [2, -2] - INDEFINITE\n');

% Show additional information in figure
figure('Position', [300 100 500 300]);
axis off;
text(0.1, 0.9, 'HESSIAN TYPE SUMMARY', 'FontSize', 12, 'FontWeight', 'bold');
text(0.1, 0.7, '• Positive Definite: Strict minimum (x² + y²)', 'FontSize', 10);
text(0.1, 0.6, '• Positive Semidefinite: Non-strict min or flat (x² + y⁴)', 'FontSize', 10);
text(0.1, 0.5, '• Indefinite: Saddle point (x² - y²)', 'FontSize', 10);
text(0.1, 0.35, 'Hessian eigenvalues determine:', 'FontSize', 10);
text(0.1, 0.25, '  - All > 0: Local minimum', 'FontSize', 10);
text(0.1, 0.15, '  - All ≥ 0: Possible minimum (semidefinite)', 'FontSize', 10);
text(0.1, 0.05, '  - Mixed signs: Saddle point', 'FontSize', 10);

%% Compact summary table display
figure('Position', [350 200 400 200]);
axis off;
text(0.05, 0.9, 'Hessian Classification Table', 'FontSize', 11, 'FontWeight', 'bold');
text(0.05, 0.75, 'Positive Definite: Strict minimum', 'FontSize', 9, 'Color', 'blue');
text(0.05, 0.60, 'Positive Semidefinite: Non-strict minimum/flat', 'FontSize', 9, 'Color', 'green');
text(0.05, 0.45, 'Indefinite: Saddle point', 'FontSize', 9, 'Color', 'red');
text(0.05, 0.30, 'Negative Definite: Strict maximum', 'FontSize', 9, 'Color', 'magenta');
text(0.05, 0.15, 'Negative Semidefinite: Non-strict maximum', 'FontSize', 9, 'Color', 'cyan');