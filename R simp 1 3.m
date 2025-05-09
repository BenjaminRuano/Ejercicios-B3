clc; clear; close all;

% Definición de la función
f = @(x) 0.2 + 25*x - 200*x.^2 + 675*x.^3 - 900*x.^4 + 400*x.^5;

% Parámetros
a = 0;
b = 0.8;
n = 6;
h = (b - a) / n;

% Puntos x
x = a:h:b;
y = f(x);

% Regla de Simpson 1/3 compuesta
I_simpson = h/3 * (y(1) + ...
                   4 * sum(y(2:2:end-1)) + ...
                   2 * sum(y(3:2:end-2)) + ...
                   y(end));

% Cuarta derivada simbólica
syms xs
fs = 0.2 + 25*xs - 200*xs^2 + 675*xs^3 - 900*xs^4 + 400*xs^5;
f4 = diff(fs, 4);
f4_fun = matlabFunction(f4);

% Valor medio de la cuarta derivada
media_f4 = integral(f4_fun, a, b) / (b - a);

% Error de truncamiento estimado
error_trunc = -((b - a)^5 / (180 * n^4)) * media_f4;

% Valor exacto de la integral
I_exact = 1.640533;

% Error relativo porcentual
error_porcentual = abs((I_exact - I_simpson) / I_exact) * 100;

% Mostrar resultados
fprintf('Integral aproximada (Simpson 1/3): %.6f\n', I_simpson);
fprintf('Valor medio de la cuarta derivada: %.6f\n', media_f4);
fprintf('Error de truncamiento estimado: %.6f\n', error_trunc);
fprintf('Error relativo porcentual: %.2f%%\n', error_porcentual);
