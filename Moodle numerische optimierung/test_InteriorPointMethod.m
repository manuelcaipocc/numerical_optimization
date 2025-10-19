clear, close all,
clc

% problem definition
c = [-1;-3;0;0];
B = [1 1 1 0 ; 2 1 0 1];
b = [3;2];

% initial values
x0      = [1/2;1/2;2;1/2];
lambda  = [-2;-2];
s       = [5;1;2;2];

% matlabs reference solution
x_matlab = linprog(c,-eye(4),zeros(4,1),B,b);

% your own code here
[x_IPM, y_IPM, s_IPM, iter_IPM] = InteriorPointMethod(c,B,b,x0,lambda,s,0.8,1e-6);

% Check the solution by compairing with matlab internal routine
fprintf('The error ||x_IPM - x_matlab||_2 = %4.3e \n', norm(x_IPM-x_matlab))