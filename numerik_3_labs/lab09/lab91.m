close all; clear; clc;

% --- 1) Region of the first constraint: x1^2 + x2^2 <= 1 (unit disk)
theta = linspace(0, 2*pi, 400);
x1_circ = cos(theta);
x2_circ = sin(theta);

figure; hold on; axis equal; grid on;
xlabel('x_1'); ylabel('x_2');
title('Constraints and Feasible Set');

% Fill the disk (optional)
% We use a meshgrid to shade the feasible region of the disk
N = 400;
x1 = linspace(-1.2, 1.2, N);
x2 = linspace(-1.2, 1.2, N);
[X1, X2] = meshgrid(x1, x2);
disk = (X1.^2 + X2.^2 <= 1);
hDisk = imagesc(x1, x2, disk);  % paints the boolean region
set(gca,'YDir','normal');
alpha(0.15);                    % transparency

% Circle border
plot(x1_circ, x2_circ, 'LineWidth', 2);

% --- 2) Second constraint: x1 = x2 (line)
t = linspace(-1.2, 1.2, 200);
plot(t, t, 'LineWidth', 2);

% --- 3) Feasible set F: intersection -> segment on the line inside the disk
% Parameterization on the line: x1=x2=t
% In the disk: 2*t^2 <= 1 => |t| <= 1/sqrt(2)
tF = linspace(-1/sqrt(2), 1/sqrt(2), 200);
plot(tF, tF, 'LineWidth', 4);

legend( ...
  'Disk (filled): x_1^2+x_2^2 \le 1', ...
  'Border: x_1^2+x_2^2 = 1', ...
  'Line: x_1 = x_2', ...
  'Feasible Set F (segment)', ...
  'Location','best' ...
);
xlim([-1.2 1.2]); ylim([-1.2 1.2]);