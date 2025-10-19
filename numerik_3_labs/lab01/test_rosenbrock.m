clear
close all
clc


% F and dF
F = @(x) ...
dF = @(x) ...

% apply Gauss-Newton method
X = gauss_newton([-3;4], F, dF, 10^(-6), 100);

% compute values of Rosenbrock function
[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );

% set figure
figure('Position', [100,100,1000,700]);
sgtitle('\underline{Rosenbrock function}', 'Interpreter', 'latex', 'FontSize', 18);

% 3D plot
subplot(2,2,1);
h = surf(x,y,z);
h.FaceAlpha = 0.9;
shading interp;
colormap(turbo(256));
hold on;
p3 = plot3(X(1,:),X(2,:), sqrt( (1-X(1,:)').^2 + (10*(X(2,:)'-X(1,:)'.^2)).^2 + X(1,:)'.^2+X(2,:)'.^2 ), '--.r', 'MarkerSize',15);
xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
zlabel('$$r(x,y)=\left\|F(x,y)\right\|_2$$', 'Interpreter', 'latex', 'FontSize', 14);
legend(p3,'iterates', 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 12);
title('3D plot', 'Interpreter', 'latex', 'FontSize', 14);
view(10,60);

% contour lines plot
subplot(2,2,2);
contour(x,y,z,100,'HandleVisibility','off');
hold on;
plot(X(1,:),X(2,:),'--.r','MarkerSize',15);
xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
caxis([0,110]);
colorbar();
rectangle('Position', [0.3-0.4/5,-0.1-0.4/5,0.4+2*0.4/5,0.4+2*0.4/5], 'EdgeColor','black', 'LineStyle',':','LineWidth',1.5);
plot(nan, nan, 'Color','black', 'LineStyle',':','LineWidth',1.5, 'DisplayName', 'zoom in');
legend('iterates', 'zoom in', 'Interpreter', 'latex', 'Location', 'northeast', 'FontSize', 12);
title('Contour line plot', 'Interpreter', 'latex', 'FontSize', 14);

% contour lines plot - zoom in
subplot(2,2,3);
[x,y] = meshgrid(linspace(0.3,0.7,100), linspace(-0.1,0.3,100));
z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );
contour(x,y,z,100,'HandleVisibility','off');
hold on;
plot(X(1,:),X(2,:), '--.r', 'MarkerSize',15);
rectangle('Position', [0.4-0.0125,0.14-0.0125,0.05+2*0.0125,0.05+2*0.0125], 'EdgeColor','black', 'LineStyle',':','LineWidth',1.5);
plot(nan, nan, 'Color','black', 'LineStyle',':','LineWidth',1.5);
xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0.3,0.7]);
ylim([-0.1,0.3]);
caxis([0,110]);
colorbar();
legend('iterates', 'zoom zoom in', 'Interpreter', 'latex', 'Location', 'southeast', 'FontSize', 12);
title('Contour line plot - zoom in', 'Interpreter', 'latex', 'FontSize', 14);

% contour lines plot - zoom zoom in
subplot(2,2,4);
[x,y] = meshgrid(linspace(0.4,0.45,100), linspace(0.14,0.19,100));
z =  sqrt( (1-x).^2 + (10*(y-x.^2)).^2 + x.^2+y.^2 );
contour(x,y,z,100);
hold on;
p4=plot(X(1,:),X(2,:), '--.r', 'MarkerSize',15);
xlabel('$$x$$', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$$y$$', 'Interpreter', 'latex', 'FontSize', 14);
xlim([0.4,0.45]);
ylim([0.14,0.19]);
caxis([0,110]);
colorbar();
legend(p4,'iterates', 'Interpreter', 'latex', 'Location', 'southeast', 'FontSize', 12);
title('Contour line plot - zoom zoom in', 'Interpreter', 'latex', 'FontSize', 14);