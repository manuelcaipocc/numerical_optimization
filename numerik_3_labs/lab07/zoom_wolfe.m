function alpha = zoom_wolfe(f, grad_f, x, d, alpha_init, c1, c2)
    alpha0 = 0;
    alpha1 = alpha_init;

    i = 1;

    while true
        phi_alpha1 = f(x + alpha1 * d);
        phi0 = f(x);
        grad_phi0 = grad_f(x)' * d;

        if (phi_alpha1 > phi0 + c1 * alpha1 * grad_phi0) || ...
           (phi_alpha1 >= f(x + alpha0 * d) && i > 1)
            alpha = zoom(alpha0, alpha1);
            return;
        end

        grad_phi_alpha1 = grad_f(x + alpha1 * d)' * d;

        if abs(grad_phi_alpha1) <= -c2 * grad_phi0
            alpha = alpha1;
            return;
        end

        if grad_phi_alpha1 >= 0
            alpha = zoom(alpha1, alpha0);
            return;
        end

        alpha0 = alpha1;
        alpha1 = 2 * alpha1;
        i = i + 1;
    end

    function a = zoom(beta1, beta2)
        while true
            a = 0.5 * (beta1 + beta2);
            phi_a = f(x + a * d);

            if (phi_a > phi0 + c1 * a * grad_phi0) || ...
               (phi_a >= f(x + beta1 * d))
                beta2 = a;
            else
                grad_phi_a = grad_f(x + a * d)' * d;
                if abs(grad_phi_a) <= -c2 * grad_phi0
                    return;
                end
                if grad_phi_a * (beta2 - beta1) >= 0
                    beta2 = beta1;
                end
                beta1 = a;
            end
        end
    end
end
