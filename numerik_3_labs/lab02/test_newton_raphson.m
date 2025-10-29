clear
close all
clc


% define functions and their derivatives
F1 = @(x) x.^2+1;
dF1 = @(x) 2*x;
ddF1 = @(x) 2;
f1 = @(x) F1(x).^2;
F2 = @(x) x.^2;
dF2 = @(x) 2*x;
ddF2 = @(x) 2;
f2 = @(x) F2(x).^2;

% set initial values and parameters
x = -3:0.01:5;
x0 = 4;
tol = 10^(-10);
maxit = 10;
% parameters for Levenberg-Marquardt
mu0 = 0.3;
beta0 = 0.3;
beta1 = 0.9;

% solve for f1 with Gauss-newton, Levenberg-Marquardt, Newton-Raphson
res_f1_gn = gauss_newton(x0, F1, dF1, tol, maxit);
res_f1_lm = levenberg_marquardt(x0, F1, dF1, mu0, beta0, beta1, tol, maxit);
res_f1_nr = newton_raphson(x0, F1, dF1, ddF1, tol, maxit);

% solve for f2 with GN, LM, NR
res_f2_gn = gauss_newton(x0, F2, dF2, tol, maxit);
res_f2_lm = levenberg_marquardt(x0, F2, dF2, mu0, beta0, beta1, tol, maxit);
res_f2_nr = newton_raphson(x0, F2, dF2, ddF2, tol, maxit);

% plot iterates for f1
subplot(2,2,1);
plot(res_f1_gn, f1(res_f1_gn), '--x');
hold on;
plot(res_f1_lm, f1(res_f1_lm), '--+');
plot(res_f1_nr, f1(res_f1_nr), '--o');
plot(x,f1(x));
xlabel('$$x$$','Interpreter','latex','FontSize',11);
ylabel('$$f_1(x)$$','Interpreter','latex','FontSize',11);
title('$$f_1(x)=\|x^2+1\|_2^2$$ and algorithms','Interpreter','latex','FontSize',14);
xlim([min(x),max(x)]);
ylim([f1(0)-1,f1(4)]);
legend('Gauss-Newton','Levenberg-Marquardt','Newton-Raphson','','Interpreter','latex','Location','northwest','FontSize',11);

% plot iterates for f2
subplot(2,2,2);
plot(res_f2_gn, f2(res_f2_gn), '--x');
hold on;
plot(res_f2_lm, f2(res_f2_lm), '--+');
plot(res_f2_nr, f2(res_f2_nr), '--o');
plot(x,f2(x));
xlabel('$$x$$','Interpreter','latex','FontSize',11);
ylabel('$$f_2(x)$$','Interpreter','latex','FontSize',11);
title('$$f_2(x)=\|x^2\|_2^2$$ and algorithms','Interpreter','latex','FontSize',14);
xlim([min(x),max(x)]);
ylim([f2(0)-1,f2(4)]);
legend('Gauss-Newton','Levenberg-Marquardt','Newton-Raphson','','Interpreter','latex','Location','northwest','FontSize',11);

% plot errors for f1
subplot(2,2,3);
semilogy(0:size(res_f1_gn,2)-1, abs(res_f1_gn), '--x');
hold on;
semilogy(0:size(res_f1_lm,2)-1, abs(res_f1_lm), '--+');
semilogy(0:size(res_f1_nr,2)-1, abs(res_f1_nr), '--o');
legend('Gauss-Newton','Levenberg-Marquardt','Newton-Raphson','Interpreter','latex','Location','southwest','FontSize',11);
xlabel('iteration steps', 'Interpreter', 'latex','FontSize',11);
ylabel('error', 'Interpreter', 'latex','FontSize',11);
title('$$f_1(x)=\|x^2+1\|_2^2$$ and errors','Interpreter','latex','FontSize',14);

% plot errors for f2
subplot(2,2,4);
semilogy(0:size(res_f2_gn,2)-1, abs(res_f2_gn), '--x');
hold on;
semilogy(0:size(res_f2_lm,2)-1, abs(res_f2_lm), '--+');
semilogy(0:size(res_f2_nr,2)-1, abs(res_f2_nr), '--o');
legend('Gauss-Newton','Levenberg-Marquardt','Newton-Raphson','Interpreter','latex','Location','southwest','FontSize',11);
xlabel('iteration steps', 'Interpreter', 'latex');
ylabel('error', 'Interpreter', 'latex','FontSize',11);
title('$$f_2(x)=\|x^2\|_2^2$$ and errors','Interpreter','latex','FontSize',14);