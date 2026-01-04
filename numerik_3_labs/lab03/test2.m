% Example of convex function in R
x = linspace(-2, 2, 400);
f = x.^2;

plot(x, f, 'LineWidth', 2); grid on;
xlabel('x'); ylabel('f(x)');
title('f(x) = x^2 is convex');

% Optional: draw the segment between two points
x1 = 0; y1 = x1^2;
x2 = 2; y2 = x2^2;
hold on;
plot([x1 x2], [y1 y2], '--r', 'LineWidth', 1.5);
legend('f(x)=x^2','segment between (0,0) and (2,4)','Location','northwest');