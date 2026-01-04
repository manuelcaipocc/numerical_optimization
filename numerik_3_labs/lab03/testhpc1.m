clc; clear; close all;

% --- Definición de matriz A (7x8) ---
A = [ ...
    0 7 14 21 28 35 42 49;
    1 8 15 22 29 36 43 50;
    2 9 16 23 30 37 44 51;
    3 10 17 24 31 38 45 52;
    4 11 18 25 32 39 46 53;
    5 12 19 26 33 40 47 54;
    6 13 20 27 34 41 48 55 ];

% --- Definición de vectores ---
y = [0 1 2 3 4 5 6]';      % (7x1)
x = [0 1 2 3 4 5 6 7]';    % (8x1)

% --- Parámetros GEMV ---
alpha = 1.0;
beta  = 2.0;

% --- Operación GEMV ---
y_result = alpha * (A * x) + beta * y;

% --- Producto punto ---
dot_xx = dot(x, x);

% --- Mostrar resultados ---
fprintf('A = \n'); disp(A);
fprintf('Y = \n'); disp(y');
fprintf('X = \n'); disp(x');
fprintf('Alpha : %.1f  Beta : %.1f\n', alpha, beta);
fprintf('Y : alpha*(A*X) + beta*Y = \n');
disp(y_result');
fprintf('Output X dot X : %.6f\n', dot_xx);