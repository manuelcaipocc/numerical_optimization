clear;
clc;
% Dimensiones:
% M = 1, N = 13, K = 3
% C = alpha * A * B + beta * C0
% alpha = -1, beta = 0

alpha = -1.0;
beta  = 0.0;

A = [ 0.819  -0.874   0.371 ];   % 1x3

B = [ ...
   -0.753   0.766   0.186  -0.826  -0.610  -0.607   0.565   0.763  -0.043   0.261  -0.936  -0.454  -0.376; ...
    0.590  -0.831   0.494   0.920   0.682  -0.245   0.678  -0.676  -0.172   0.861  -0.079   0.721   0.485; ...
    0.040  -0.557   0.375   0.576   0.659   0.407   0.146   0.918   0.881  -0.394  -0.493   0.357   0.273 ...
];  % 3x13

% C0 lleno de NaN (como en el test), pero con beta=0 no influye:
C0 = zeros(1,13);

% Referencia BLAS: Cref = alpha*A*B + beta*C0
Cref = alpha * (A * B) + beta * C0;

disp('Cref = ');
disp(Cref);



%% Datos del test
A = [ 0.6804   -0.2112    0.5662 ];   % 1x3

B = [
    0.0268    0.2714    0.2139   -0.7255   -0.1981    0.9978    0.6782    0.2751    0.9456    0.0535    0.7831    0.6154    0.8987;
    0.9045    0.4346   -0.9674    0.6084   -0.7404   -0.5635    0.2253    0.0486   -0.4150    0.5398   -0.4334    0.8381    0.0520;
    0.8324   -0.7168   -0.5142   -0.6866   -0.7824    0.0259   -0.4079   -0.0128    0.5427   -0.1995   -0.2951   -0.8605   -0.8279
];

alpha = -1.0;
beta  =  0.0;

% C inicial con NaN (colvector 1x13)
C0 = nan(1,13);

%% Resultado correcto según BLAS
Cref = alpha * (A * B) + beta * C0;   % beta=0 elimina los NaN

%% Resultado obtenido por tu implementación
Ctst = [
   -0.2985  0.3130 -0.0588  1.0109  0.4214 -0.8126 -0.1829 ...
   -0.1696 -1.0383  0.1906 -0.4572  0.2455 -0.1317
];

%% Comparación
disp('Cref (MATLAB) =');
disp(Cref);

disp('Ctst (tu GEMM) =');
disp(Ctst);

disp('Diferencia Ctst - Cref =');
disp(Ctst - Cref);

%% Verificación numérica
max_err = max(abs(Ctst - Cref));
disp(['Error máximo = ', num2str(max_err)]);
