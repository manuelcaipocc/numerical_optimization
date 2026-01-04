function [X, Delta_hist] = trust_region_cauchy( ...
        f, grad_f, H_f, ...
        x0, tol, max_it, Delta0, ...
        eta1, eta2, nu1, nu2)
% TRUST_REGION_CAUCHY
% Implementa el método de región de confianza con paso de Cauchy.
%
% ENTRADAS:
%   f       : handle a la función f(x)
%   grad_f  : handle al gradiente, grad_f(x)
%   H_f     : handle al Hessiano, H_f(x)
%   x0      : punto inicial (vector columna)
%   tol     : tolerancia para ||grad f(x_k)||
%   max_it  : número máximo de iteraciones
%   Delta0  : radio inicial de la región de confianza
%   eta1, eta2, nu1, nu2 : parámetros del algoritmo
%
% SALIDAS:
%   X          : matriz con todos los iterados (cada columna es un x_k)
%   Delta_hist : vector con los radios de región de confianza en cada k

    % Aseguramos que x0 sea un vector columna
    xk = x0(:);
    n  = length(xk);

    % Reservamos memoria (luego recortamos al final)
    X          = zeros(n, max_it + 1);
    Delta_hist = zeros(max_it + 1, 1);

    X(:,1)          = xk;
    Delta_hist(1)   = Delta0;

    k = 0;  % contador de iteraciones (corresponde al x_k)

    while k < max_it
        k = k + 1;   % vamos a construir x_k a x_{k+1}

        % Gradiente y norma
        gk = grad_f(xk);
        gnorm = norm(gk);

        % Criterio de parada: gradiente pequeño
        if gnorm < tol
            break;
        end

        % Hessiano
        Hk = H_f(xk);

        % ---- 1) Calcular el paso de Cauchy p_k -----------------------
        gHg = gk' * Hk * gk;

        Delta_k = Delta_hist(k);

        if gHg <= 0
            % Caso de curvatura no positiva
            % p_k = - (Delta_k / ||g||) * g
            pk = - (Delta_k / gnorm) * gk;
        else
            % Caso normal: usamos la fórmula del punto de Cauchy
            % alpha1 = ||g||^2 / (g^T H g)
            % alpha2 = Delta_k / ||g||
            % alpha  = min(alpha1, alpha2)
            % p_k    = - alpha * g
            alpha1 = (gnorm^2) / gHg;
            alpha2 = Delta_k / gnorm;
            alpha  = min(alpha1, alpha2);
            pk     = - alpha * gk;
        end

        % ---- 2) Calcular razón entre reducción real y prevista -------
        fk      = f(xk);
        fk_new  = f(xk + pk);

        % Reducción real
        act_red = fk - fk_new;

        % Reducción prevista por el modelo cuadrático
        % m_k(p) = f(x_k) + g_k^T p + 0.5 p^T H_k p
        % => red_pred = m_k(0) - m_k(p) = - g_k^T p - 0.5 p^T H_k p
        pred_red = - gk' * pk - 0.5 * pk' * Hk * pk;

        % Para evitar problemas numéricos
        if pred_red <= 0
            rho = 0;
        else
            rho = act_red / pred_red;
        end

        % ---- 3) Aceptar o rechazar el paso ---------------------------
        if rho > eta1
            x_next = xk + pk;   % aceptamos
        else
            x_next = xk;        % rechazamos
        end

        % ---- 4) Actualizar el radio de la región de confianza --------
        Delta_next = Delta_k;

        if rho <= eta1
            % Paso malo -> reducimos el radio
            Delta_next = nu1 * Delta_k;
        elseif (rho >= eta2) && (abs(Delta_k - norm(pk)) < 1e-12)
            % Paso muy bueno y en el borde -> aumentamos el radio
            Delta_next = nu2 * Delta_k;
        end

        % Guardar resultados
        X(:, k+1)        = x_next;
        Delta_hist(k+1)  = Delta_next;

        % Preparar siguiente iteración
        xk = x_next;
    end

    % Recortamos X y Delta_hist al número real de iteraciones usadas
    X          = X(:, 1:(k+1));
    Delta_hist = Delta_hist(1:(k+1));
end
