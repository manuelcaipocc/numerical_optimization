clear
clc
close all


% number of data points
m = 20;

% create random data points roughly arranged in circle
c_r = rand(2,1)*10;
r_r = rand(1,1)*10;
ang = rand(m,1)*2*pi;
dev = rand(m,1)*0.2+0.9;
x = c_r(1)+r_r*cos(ang).*dev;
y = c_r(2)+r_r*sin(ang).*dev;

% set up function handles F and dF; z(1) = x_c, z(2) = y_c, z(3) = r
F = @(z) ...
dF = @(z) ...

% set inputs for Gauss-Newton method
x0 = [5;5;5];
tol = 10^(-10);
maxit = 100;

% perform Gauss-Newton method
sol = gauss_newton(x0, F, dF, tol, maxit);
sol = sol(:,end);
x_c = sol(1);
y_c = sol(2);
r = sol(3);

% plot data points and computed circle
figure();
x_circ = x_c + r * cos(linspace(0,2*pi,100));
y_circ = y_c + r * sin(linspace(0,2*pi,100));
plot(x,y,'*red');
hold on;
plot(x_circ,y_circ,'blue');
xlim([x_c-r-0.5, x_c+r+0.5]);
ylim([y_c-r-0.5, y_c+r+0.5]);
legend('data points', 'minimizing circle', 'Interpreter', 'latex');

% plot ||F(x_c,y_c,t)||_2 with varying radius t
figure();
R = -2*abs(r):0.01:2*abs(r);
F_r = zeros(length(R),1);
k = 1;
for t = R
    F_r(k) = norm(F([x_c, y_c, t]));
    k = k+1;
end
plot(R, F_r);
ylabel('$$\|F(x_c,y_c,\tilde{r})\|_2$$', 'Interpreter', 'latex', 'FontSize', 14);
xlabel('radii $$\tilde{r}$$', 'Interpreter', 'latex', 'FontSize', 14);
xline(r, '--r');
xline(-r, '--r');
text(-abs(r)+0.2, max(F_r)/2, '$$-\vert r\vert$$', 'Interpreter', 'latex', 'Color', 'red');
text(abs(r)+0.2, max(F_r)/2, '$$\vert r\vert$$', 'Interpreter', 'latex', 'Color', 'red');