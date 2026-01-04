clear
close all
clc


%% Rosenbrock's function

% function
f = @(x) sqrt((1-x(1)).^2 + 100*(x(2)-x(1).^2).^2 + x(1).^2+x(2).^2); 

% random starting point
x0 = rand(2,1)*6-[3;2];

% initial step sizes and tolerance
h0 = [0.1;0.1];
tol = 10^(-8);

% perform Hooke-Jeeves method
X = hooke_jeeves(f, x0, h0, tol);

% plot function and iterates
[x,y] = meshgrid(linspace(-3,3,100), linspace(-2,4,100));
z = sqrt((1-x).^2 + 100*(y-x.^2).^2 + x.^2+y.^2); 

subplot(1,2,1);
contour(x,y,z,100,'HandleVisibility','off');
hold on;
plot(X(1,:),X(2,:),'.--r','MarkerSize',15);

x_final = X(:,end);

% agregar leyenda con el valor final
legend(sprintf('Final: (%.3f, %.3f)', x_final(1), x_final(2)), ...
       'Location','best','FontSize',9);
title('Rosenbrock function','Interpreter','latex','FontSize',15);

xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');
%% Himmbelblau's function

% function
f = @(x) (x(1).^2+x(2)-11).^2 + (x(1)+x(2).^2-7).^2;

% random starting point
x0 = rand(2,1)*8-[4;4];

% initial step sizes and tolerance
h0 = [0.1;0.1];
tol = 10^(-8);

% perform Hooke-Jeeves method
X = hooke_jeeves(f, x0, h0, tol);

% plot function and iterates
[x,y] = meshgrid(linspace(-4,4,100), linspace(-4,4,100));
z = (x.^2+y-11).^2 + (x+y.^2-7).^2;
subplot(1,2,2);
contour(x,y,z,100,'HandleVisibility','off');
hold on;
plot(X(1,:),X(2,:),'.--r','MarkerSize',15);

x_final = X(:,end);

% agregar leyenda con el valor final
legend(sprintf('Final: (%.3f, %.3f)', x_final(1), x_final(2)), ...
       'Location','best','FontSize',9);

title('Himmelblau function','Interpreter','latex','FontSize',15);
xlabel('$x_1$','Interpreter','latex');
ylabel('$x_2$','Interpreter','latex');