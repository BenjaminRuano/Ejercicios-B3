clc; clear; close all;


% Definición de la función
f = @(x) 1 + 2*x - 3*x.^2 + 4*x.^3 - 5*x.^4 + 6*x.^5;

% Intervalo y subintervalos
a = 0;
b = 1;
n = 5;              % Número de subintervalos
h = (b - a)/n;

x = a:h:b;          % Puntos del intervalo
y = f(x);           % Evaluación de f en los puntos

% -----------------------------
% Simpson 1/3 para n = 4 (últimos 4 puntos)
% -----------------------------
I13 = (h/3) * ( y(2) + 4*y(3) + y(4) );

% -----------------------------
% Simpson 3/8 para n = 3 (primeros 3 subintervalos)
% -----------------------------
I38 = (3*h/8) * ( y(1) + 3*y(2) + 3*y(3) + y(4) );

% -----------------------------
% Integral total
% -----------------------------
I_total = I38 + I13;

% -----------------------------
% Valor exacto con integral()
% -----------------------------
f_exact = integral(f, a, b);

% -----------------------------
% Derivada cuarta (para error teórico)
% f''''(x) = 24*4 - 120*3*x + 720*x.^2
syms xs
f_sym = 1 + 2*xs - 3*xs^2 + 4*xs^3 - 5*xs^4 + 6*xs^5;
d4f = diff(f_sym, xs, 4);         % Cuarta derivada simbólica
f4 = matlabFunction(d4f);         % Convertir a función
f4_vals = f4(x);
f4_avg = mean(abs(f4_vals));     % Valor medio de |f''''(x)|

% -----------------------------
% Estimación del error de truncamiento (Simpson 1/3 + 3/8)
% E <= -((b - a) * h^4 / 180) * f''''(ξ)
% Para fines prácticos se usa el valor medio
E_est = -((b - a) * h^4 / 180) * f4_avg;

% -----------------------------
% Error relativo porcentual
% -----------------------------
error_rel = abs((f_exact - I_total)/f_exact) * 100;

% -----------------------------
% Mostrar resultados
% -----------------------------
fprintf('Integral aproximada (Simpson 1/3): %.10f\n', I13);
fprintf('Integral aproximada (Simpson 3/8): %.10f\n', I38);
fprintf('Integral aproximada total: %.10f\n', I_total);
fprintf('Valor medio de la cuarta derivada: %.10f\n', f4_avg);
fprintf('Error de truncamiento estimado: %.10e\n', E_est);
fprintf('Error relativo porcentual: %.10f %%\n', error_rel);
