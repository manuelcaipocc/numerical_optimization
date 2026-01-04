% --- 1. Initialization and Vector Definitions ---
clear; clc; close all;

% Define the components of the hyperplane in its PARAMETRIC form
% x = p + s1*d1 + s2*d2
p = [1; 1; 0];
d1 = [1/2; 0; 1/2];      % Direction vector 1 (CORRECTED)
d2 = [0; -1/2; -1/2];    % Direction vector 2 (CORRECTED)

% Define the points to be checked
q1 = [3/2; -1; -1/2];    % This point should NOT be on the plane
q2 = [5/2; -1; -1/2];    % This point SHOULD be on the plane

% --- 2. Calculation of the Normal Form (the task for part "b") ---
% The normal vector 'v' is perpendicular to the direction vectors.
% We calculate it using the cross product.
v_normal = cross(d1, d2);

% Note: v_normal will be [0.25; 0.25; -0.25]. To simplify visualization and
% manual calculations, we can use a scalar multiple, like v = [1; 1; -1].
% MATLAB handles either form fine, but it's good to be aware.
% We will use the scaled normal vector for plotting the quiver (arrow).
v_scaled = v_normal * 4; % -> Results in [1; 1; -1]

% --- 3. Creating the Meshgrid to Draw the Plane ---
% We create a grid of values for the parameters s1 and s2.
% This allows us to generate many points on the plane to draw it as a surface.
[s1_grid, s2_grid] = meshgrid(-5:0.5:5); 

% Calculate the (x, y, z) coordinates for each point in the plane's grid
% using the parametric form.
X = p(1) + s1_grid .* d1(1) + s2_grid .* d2(1);
Y = p(2) + s1_grid .* d1(2) + s2_grid .* d2(2);
Z = p(3) + s1_grid .* d1(3) + s2_grid .* d2(3);

% --- 4. Graphical Visualization ---
figure;
hold on; % Allows plotting multiple elements in the same figure
grid on;
axis equal; % Ensures that the proportions on all axes are the same

% Plot the hyperplane (the surface)
surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none', 'DisplayName', 'Hyperplane H');
colormap(winter);

% Plot the anchor point 'p' (the known point on the plane)
plot3(p(1), p(2), p(3), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'DisplayName', 'Point p');

% Plot points q1 and q2 to visually check their positions
plot3(q1(1), q1(2), q1(3), 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 10, 'DisplayName', 'Point q1 (Outside)');
plot3(q2(1), q2(2), q2(3), 'go', 'MarkerFaceColor', 'g', 'MarkerSize', 10, 'DisplayName', 'Point q2 (Inside)');

% Add the normal vector! This is the key visualization for part (b).
% We draw it starting from point 'p'. The quiver3 function draws arrows.
quiver3(p(1), p(2), p(3), v_scaled(1), v_scaled(2), v_scaled(3), ...
    'm', 'LineWidth', 2, 'MaxHeadSize', 0.5, 'DisplayName', 'Normal Vector v');

% --- 5. Final Plot Configuration ---
title('Visualization of Hyperplane H, Points, and Normal Vector');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
legend('show', 'Location', 'northwest');
view(30, 25); % Adjust the viewing angle for a better perspective
rotate3d on;  % Allows rotating the figure with the mouse

hold off;