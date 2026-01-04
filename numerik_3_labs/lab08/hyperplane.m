clear;
clc;
% --- Definición de los vectores del hiperplano H ---
p = [1; 1; 0];
u1 = [0; 0; 1/2];
u2 = [1/2; -1; -1/2];

% --- Definición de los puntos a verificar ---
q1 = [3/2; -1; -1/2];
q2 = [5/2; -1; -1/2];

% --- Creación de una malla de puntos para dibujar el plano ---
% Creamos una rejilla de valores para los parámetros s1 y s2
[s1_grid, s2_grid] = meshgrid(-5:0.5:5); % Rango de s1 y s2 para la visualización

% Calculamos las coordenadas (x, y, z) de los puntos en el plano
X = p(1) + s1_grid .* u1(1) + s2_grid .* u2(1);
Y = p(2) + s1_grid .* u1(2) + s2_grid .* u2(2);
Z = p(3) + s1_grid .* u1(3) + s2_grid .* u2(3);

% --- Visualización ---
figure;
hold on;
grid on;
axis equal;

% Dibujar el hiperplano (la superficie plana)
surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Hyperplane H');
colormap(winter);

% Dibujar el punto de anclaje 'p'
plot3(p(1), p(2), p(3), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Point p');

% Dibujar los puntos q1 y q2
plot3(q1(1), q1(2), q1(3), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10, 'DisplayName', 'Point q1');
plot3(q2(1), q2(2), q2(3), 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 10, 'DisplayName', 'Point q2');

% Configuración del gráfico
title('Visualization of Hyperplane H and Points');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend('show');
view(30, 25); % Ajusta el ángulo de la vista para una mejor perspectiva

hold off;