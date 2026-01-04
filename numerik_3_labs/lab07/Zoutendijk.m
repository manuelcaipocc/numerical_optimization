%% Zoutendijk demo extendido: superficie 3D + contour en una sola figura
clear; close all; clc;

%% ============================================================
% 1) DEFINIR FUNCIÓN
%     f(x,y) = x^2 + 100 y^2
%% ============================================================
f = @(x,y) x.^2 + 100*y.^2;

% malla para graficar
x = linspace(-3,3,120);
y = linspace(-1,1,120);
[X,Y] = meshgrid(x,y);
Z = f(X,Y);


%% ============================================================
% 2) CREAR FIGURA CON DOS SUBPLOTS
%% ============================================================
figure('Name','Zoutendijk 3D + Contour','NumberTitle','off');
set(gcf,'Position',[200 200 1300 500]);  % ventana grande


%% ============================================================
% SUBPLOT 1: SUPERFICIE 3D
%% ============================================================
subplot(1,2,1);
surf(X,Y,Z,'EdgeColor','none','FaceAlpha',0.85);
colormap(parula);
xlabel('x'); ylabel('y'); zlabel('f(x,y)');
title('Superficie 3D de f(x,y) = x^2 + 100y^2');
view(40,35);
grid on; hold on;

% Punto x_k en la superficie
xk = [2; 0.2];
zk = f(xk(1),xk(2));
plot3(xk(1),xk(2),zk, 'ko', 'MarkerFaceColor','k','MarkerSize',8);


%% ============================================================
% CALCULAR GRADIENTE Y DIRECCIONES
%% ============================================================
grad_fk = [2*xk(1); 200*xk(2)];
neg_grad = -grad_fk;
ng_dir = neg_grad / norm(neg_grad);

delta = 0.5;                        % cos(theta)>=delta
theta_max = acos(delta);
R = @(ang)[cos(ang) -sin(ang); sin(ang) cos(ang)];

b1 = R(+theta_max)*ng_dir;
b2 = R(-theta_max)*ng_dir;
L = 1.0;

bad_dir  = [1; 0.05];  bad_dir  = bad_dir / norm(bad_dir);
good_dir = R(30*pi/180)*ng_dir; 
good_dir = good_dir / norm(good_dir);


%% ============================================================
% SUBPLOT 2: CONTOUR + DIRECCIONES
%% ============================================================
subplot(1,2,2); hold on; grid on; axis equal;
contour(X,Y,Z,30);
xlabel('x'); ylabel('y');
title('Cono de Zoutendijk + Direcciones en el plano (contour)');
view(60,60);
% Punto x_k
plot(xk(1),xk(2),'ko','MarkerFaceColor','k','MarkerSize',8);

% Dibujar gradiente y -gradiente
quiver(xk(1),xk(2), grad_fk(1),grad_fk(2),0.2,'r','LineWidth',1.5);
quiver(xk(1),xk(2), neg_grad(1),neg_grad(2),0.2,'g','LineWidth',1.5);

% Cono
plot([xk(1), xk(1)+L*b1(1)], [xk(2), xk(2)+L*b1(2)], 'g--','LineWidth',1.2);
plot([xk(1), xk(1)+L*b2(1)], [xk(2), xk(2)+L*b2(2)], 'g--','LineWidth',1.2);

% Direccion mala
quiver(xk(1),xk(2),bad_dir(1),bad_dir(2),0.8,'b','LineWidth',1.5);

% Direccion buena
quiver(xk(1),xk(2),good_dir(1),good_dir(2),0.8,'m','LineWidth',1.5);

legend({'contour','x_k','\nabla f','-\nabla f',...
        'Borde cono','Borde cono','Dir mala','Dir buena'},...
        'Location','bestoutside');

xlim([-3 3]); ylim([-1 1]);


%% ============================================================
% 3 PRINT MÉTODOS ANTERIORES
%% ============================================================
fprintf('\n====================== Direcciones en otros métodos ======================\n');

fprintf('\n1) GRADIENT DESCENT\n');
fprintf('   d_k = -∇f(x_k)\n');
fprintf('   Muy estable, siempre dentro del mejor rango (ángulo = 0°).\n');

fprintf('\n2) GAUSS-NEWTON / GAUSS-MELBERG\n');
fprintf('   d_k = -(J^T J)^{-1} J^T f\n');
fprintf('   Puede volverse MUY mala si J^T J está mal condicionado.\n');

fprintf('\n3) CONJUGATE GRADIENT NO LINEAL (FR/PR/HS)\n');
fprintf('   d_k = -∇f(x_k) + β_k d_{k-1}\n');
fprintf('   Si β_k grande → dirección puede volverse casi perpendicular al gradiente.\n');
fprintf('   Aquí Zoutendijk es CRÍTICO para garantizar convergencia global.\n');

fprintf('\n=========================================================================\n');
