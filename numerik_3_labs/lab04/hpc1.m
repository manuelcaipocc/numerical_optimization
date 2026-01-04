% Definir las matrices A y B
A = [1.0000    11.0000    21.0000
     2.0000    12.0000    22.0000
     3.0000    13.0000    23.0000
     4.0000    14.0000    24.0000
     5.0000    15.0000    25.0000];

B = [0.5000     0.6000     0.7000     0.8000     0.9000     1.0000     1.1000
     1.5000     1.6000     1.7000     1.8000     1.9000     2.0000     2.1000
     2.5000     2.6000     2.7000     2.8000     2.9000     3.0000     3.1000];

% Matriz de prueba proporcionada
C_test = [69.5000    72.8000    76.1000    79.4000    82.7000    86.0000    89.3000
          74.0000    77.6000    81.2000    84.8000    88.4000    92.0000    95.6000
          78.5000    82.4000    86.3000    90.2000    94.1000    98.0000   101.9000
          83.0000    87.2000    91.4000    95.6000    99.8000   104.0000   108.2000
          87.5000    92.0000    96.5000   101.0000   105.5000   110.0000   114.5000];

% Realizar la multiplicación de matrices
C_calculada = A * B;

% Mostrar resultados
disp('Matriz A:');
disp(A);

disp('Matriz B:');
disp(B);

disp('Matriz C calculada (A * B):');
disp(C_calculada);

disp('Matriz C de prueba:');
disp(C_test);

% Verificar si son iguales
diferencia = abs(C_calculada - C_test);
tolerancia = 1e-4; % Tolerancia para comparación de números de punto flotante

if max(diferencia(:)) < tolerancia
    disp('✓ ¡La multiplicación es CORRECTA! Las matrices coinciden.');
else
    disp('✗ ¡La multiplicación es INCORRECTA! Las matrices no coinciden.');
    disp('Diferencia máxima:');
    disp(max(diferencia(:)));
end

% Mostrar diferencia detallada
disp('Diferencia entre matrices:');
disp(diferencia);


%% Verificación de GEMM de C++ en MATLAB

% Dimensiones (solo informativo)
m = 5; n = 7; k = 3;

%% Matrices A y B (como en tu C++)
A = [ ...
    1  11 21;
    2  12 22;
    3  13 23;
    4  14 24;
    5  15 25];

B = [ ...
    0.5 0.6 0.7 0.8 0.9 1.0 1.1;
    1.5 1.6 1.7 1.8 1.9 2.0 2.1;
    2.5 2.6 2.7 2.8 2.9 3.0 3.1];

%% C inicial (C_test antes de llamar a GEMM, beta=1)
C_init = [ ...
    1  2  3  4  5  6  7;
    2  3  4  5  6  7  8;
    3  4  5  6  7  8  9;
    4  5  6  7  8  9 10;
    5  6  7  8  9 10 11];

%% Resultados que te dio tu GEMM en C++ (copiados del output)

% Caso 1: alpha = 1, beta = 1  --> C_test final
C_cpp_beta1 = [ ...
   70.5000   74.8000   79.1000   83.4000   87.7000   92.0000   96.3000;
   76.0000   80.6000   85.2000   89.8000   94.4000   99.0000  103.6000;
   81.5000   86.4000   91.3000   96.2000  101.1000  106.0000  110.9000;
   87.0000   92.2000   97.4000  102.6000  107.8000  113.0000  118.2000;
   92.5000   98.0000  103.5000  109.0000  114.5000  120.0000  125.5000];

% Caso 2: alpha = 1, beta = 0  --> C_test_nan final
C_cpp_beta0 = [ ...
   69.5000   72.8000   76.1000   79.4000   82.7000   86.0000   89.3000;
   74.0000   77.6000   81.2000   84.8000   88.4000   92.0000   95.6000;
   78.5000   82.4000   86.3000   90.2000   94.1000   98.0000  101.9000;
   83.0000   87.2000   91.4000   95.6000   99.8000  104.0000  108.2000;
   87.5000   92.0000   96.5000  101.0000  105.5000  110.0000  114.5000];

%% Verificación para alpha = 1, beta = 1

alpha = 1.0;
beta  = 1.0;

C_ref_beta1 = alpha * (A * B) + beta * C_init;

err_beta1 = max(abs(C_ref_beta1(:) - C_cpp_beta1(:)));

fprintf('Error máximo (alpha=1, beta=1): %.3e\n', err_beta1);

%% Verificación para alpha = 1, beta = 0
% En este caso, matemáticamente: C = alpha*A*B + 0*C_init = A*B

alpha = 1.0;
beta  = 0.0;

C_ref_beta0 = alpha * (A * B);

err_beta0 = max(abs(C_ref_beta0(:) - C_cpp_beta0(:)));

fprintf('Error máximo (alpha=1, beta=0): %.3e\n', err_beta0);

%% Si quieres, puedes poner asserts con una tolerancia
tol = 1e-12;
assert(err_beta1 < tol, 'GEMM (alpha=1,beta=1) no coincide con MATLAB');
assert(err_beta0 < tol, 'GEMM (alpha=1,beta=0) no coincide con MATLAB');

disp('Todo OK: resultados de tu GEMM coinciden con MATLAB dentro de la tolerancia.');
