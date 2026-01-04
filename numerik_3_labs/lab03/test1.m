figure; hold on; axis equal
set(gcf, 'Color', 'w')

% --- Convex set: filled triangle ---
K = [0 0; 1 0; 0.3 0.8];
patch(K(:,1), K(:,2), [0.7 0.9 1], 'EdgeColor', 'b', 'LineWidth', 1.5)
text(0.3, 0.4, 'Convex set', 'Color', 'b', 'FontSize', 12)

% Choose two points inside the triangle
xA = [0.2, 0.2];
xB = [0.7, 0.3];
plot([xA(1), xB(1)], [xA(2), xB(2)], 'b--', 'LineWidth', 2)
plot(xA(1), xA(2), 'bo', 'MarkerFaceColor', 'b')
plot(xB(1), xB(2), 'bo', 'MarkerFaceColor', 'b')

% Convex intermediate points
for a = [0.25, 0.5, 0.75]
    z = a*xA + (1-a)*xB;
    plot(z(1), z(2), 'bs', 'MarkerFaceColor', 'c', 'MarkerSize', 8)
end

% --- Non-convex set: two separated disks ---
theta = linspace(0,2*pi,200);
r = 0.3;
x1 = 2 + r*cos(theta); y1 = 0 + r*sin(theta);
x2 = 3 + r*cos(theta); y2 = 0 + r*sin(theta);
fill(x1,y1,[1 0.85 0.85],'EdgeColor','r','LineWidth',1.5)
fill(x2,y2,[1 0.85 0.85],'EdgeColor','r','LineWidth',1.5)
text(2.2, 0.6, 'Non-convex', 'Color', 'r', 'FontSize', 12)

% Two points, one in each disk
A = [2.0, 0.0];
B = [3.0, 0.0];
plot([A(1), B(1)], [A(2), B(2)], 'r--', 'LineWidth', 2)
plot(A(1), A(2), 'ro', 'MarkerFaceColor','r')
plot(B(1), B(2), 'ro', 'MarkerFaceColor','r')

% Midpoint between A and B
z = 0.5*A + 0.5*B;
plot(z(1), z(2), 'rs', 'MarkerFaceColor','y', 'MarkerSize',8)

title('Convexity vs Non-convexity','FontSize',14)
axis([-0.5 3.5 -0.5 1])
xlabel('x_1'); ylabel('x_2')