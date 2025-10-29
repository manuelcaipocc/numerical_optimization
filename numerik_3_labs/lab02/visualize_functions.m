clear
close all
clc



% define f1 and f2
f1 = @(x,y) x.^2+y.^2+10*(2-cos(2*pi*x)-cos(2*pi*y));
f2 = @(x,y) 1+(x.^2+y.^2)/4000-cos(x).*cos(y/sqrt(2));

% plot f1 in 3d
figure('Position', [100,100,1000,700]);
subplot(2,2,1);
[x,y] = meshgrid(-10:0.01:10,-10:0.01:10);
z = f1(x,y);
h = surf(x,y,z);
h.FaceAlpha = 0.9;
shading interp;
colormap(turbo(256));
title('$$f_1$$ in 3D', 'Interpreter', 'latex','FontSize',14);
xlabel('$$x$$','Interpreter','latex');
ylabel('$$y$$','Interpreter','latex');
zlabel('$$f_1(x,y)$$','Interpreter','latex');
caxis([0,220]);
colorbar();

% plot f1 in contour lines
subplot(2,2,2);
contour(x,y,z);
shading interp;
colormap(turbo(256));
title('$$f_1$$ in contour lines', 'Interpreter', 'latex','FontSize',14);
xlabel('$$x$$','Interpreter','latex');
ylabel('$$y$$','Interpreter','latex');
caxis([0,220]);
colorbar();

% plot f2 in 3d
subplot(2,2,3);
[x,y] = meshgrid(-10:0.01:10,-10:0.01:10);
z = f2(x,y);
h = surf(x,y,z);
h.FaceAlpha = 0.9;
shading interp;
colormap(turbo(256));
title('$$f_2$$ in 3D', 'Interpreter', 'latex','FontSize',14);
xlabel('$$x$$','Interpreter','latex');
ylabel('$$y$$','Interpreter','latex');
zlabel('$$f_2(x,y)$$','Interpreter','latex');
caxis([0,2.05]);
colorbar();

% plot f2 in contour lines
subplot(2,2,4);
contour(x,y,z);
shading interp;
colormap(turbo(256));
title('$$f_2$$ in contour lines', 'Interpreter', 'latex','FontSize',14);
xlabel('$$x$$','Interpreter','latex');
ylabel('$$y$$','Interpreter','latex');
caxis([0,2.05]);
colorbar();