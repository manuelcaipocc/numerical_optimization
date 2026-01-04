clear
close all
clc


% function
f = @(x) sqrt((1-x(1)).^2 + 100*(x(2)-x(1).^2).^2 + x(1).^2+x(2).^2); 

% random starting vertices
S = rand(2,3)*6-[3;2];

% parameters
tol = 10^(-4);
kmax = 100;
alpha = 1;
beta = 2;
gamma = 0.5;
sigma = 0.5;

% prepare plot
[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z = sqrt((1-x).^2 + 100*(y-x.^2).^2 + x.^2+y.^2); 
figure('Position', [10 10 1000 750]);
contour(x,y,z,100,'HandleVisibility','off');
hold on;
p_plot = plot([S(1,:),S(1,1)],[S(2,:),S(2,1)],'.--r','MarkerSize',15);
title('\underline{Rosenbrock function}','Interpreter','latex','FontSize',15);
t_plot = subtitle('','Interpreter','latex','FontSize',13);
pause(4);

% perform Nelder-Mead method
nelder_mead(f, S, tol, kmax, alpha, beta, gamma, sigma, p_plot, t_plot);