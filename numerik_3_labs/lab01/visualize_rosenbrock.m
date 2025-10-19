clear
close all
clc

figure('Position', [100,100,1500,700]);
sgtitle('\underline{Rosenbrock function}', 'Interpreter', 'latex', 'FontSize', 18);

% compute values of Rosenbrock function
[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );

% 3D plot
subplot(1,2,1);
plot3(0.4243,0.1783,0.7367,'.r','MarkerSize',20);
hold on;
h = surf(x,y,z);
h.FaceAlpha = 0.9;
shading interp;
colormap(turbo(256));
xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
zlabel('$$r(x,y) = \left\|F(x,y)\right\|_2$$', 'Interpreter', 'latex', 'FontSize', 14);
legend('global and local minimum', 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 14);
title('3D plot', 'Interpreter', 'latex', 'FontSize', 14);

% contour lines plot
subplot(1,2,2);
plot(0.4243,0.1783,'.r','MarkerSize',20);
hold on;
contour(x,y,z,100);
colorbar();
xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
legend('global and local minimum', 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 14);
title('Contour line plot', 'Interpreter', 'latex', 'FontSize', 14);