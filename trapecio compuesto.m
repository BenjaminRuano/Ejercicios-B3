clc;
clear;

% Definición de la función
f = @(x) 0.2 + 25.*x - 200.*x.^2 + 675.*x.^3 - 900.*x.^4 + 400.*x.^5;

% Segunda derivada de la función (analítica)
f2 = @(x) -400 + 4050.*x - 10800.*x.^2 + 8000.*x.^3;

% Límites de integración
a = 0;
b = 0.8;

% Valor exacto dado
I_exacta = 1.640533;

% Solicitar número de segmentos
n = input('Ingrese el número de segmentos (n): ');

% Calcular el paso
h = (b - a) / n;

% Vector de puntos
x = a:h:b;

% Evaluación de la regla del trapecio compuesto
sumatoria = f(x(1)) + f(x(end)) + 2*sum(f(x(2:end-1)));
I_aprox = (h / 2) * sumatoria;

% Error absoluto
error_abs = abs(I_exacta - I_aprox);

% Cálculo del error porcentual estimado (cota teórica del error del trapecio)
% Error_teorico ≤ ((b - a)^3 / (12 * n^2)) * max|f''(x)|
x_fina = linspace(a, b, 1000);
max_f2 = max(abs(f2(x_fina)));
error_teorico = ((b - a)^3 / (12 * n^2)) * max_f2;
error_porcentual_teorico = (error_teorico / I_exacta) * 100;

% Mostrar resultados
fprintf('\nResultado de la integración usando la regla del trapecio compuesto:\n');
fprintf('Valor aproximado: %.6f\n', I_aprox);
fprintf('Error absoluto: %.6f\n', error_abs);
fprintf('Cota de error teórico (estimado con 2da derivada): %.6f\n', error_teorico);
fprintf('Error porcentual estimado: %.4f %%\n', error_porcentual_teorico);
