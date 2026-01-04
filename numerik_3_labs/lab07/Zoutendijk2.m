%% Funcion Rosenbrock
f  = @(x) 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
gf = @(x) [-400*x(1)*(x(2)-x(1)^2) - 2*(1-x(1)); 
            200*(x(2)-x(1)^2)];

%% Wolfe parameters
c1 = 1e-4; c2 = 0.9;

%% Inicial
x = [-1.2; 1];
delta = 0.2;   % exigimos cos(theta)>=0.2
N = 50;

angles = zeros(1,N);

for k=1:N
    g = gf(x);
    
    % Direccion descendente (steepest)
    d = -g;
    
    % Calcula cos(theta)
    cos_theta = -(g'/norm(g))*(d/norm(d));
    angles(k) = cos_theta;
    
    % Búsqueda lineal tipo Wolfe
    alpha = 1;
    while true
        x_new = x + alpha*d;
        g_new = gf(x_new);
        if f(x_new) <= f(x) + c1*alpha*(g'*d) && ...
           g_new'*d >= c2*(g'*d)
            break;
        end
        alpha = alpha / 2;
        if alpha < 1e-12
            break;
        end
    end
    
    x = x_new;
end

figure;
plot(1:N,angles,'LineWidth',1.5);
ylabel('cos(theta_k)');
xlabel('Iteracion');
title('Verificación empírica del efecto Zoutendijk con Wolfe');
grid on;
