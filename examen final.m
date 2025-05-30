clc; clear; close all;

% Datos 
f = @(x) exp(-x.^2);
a = 0;
b = 1.5;
n = 6;
valor_exacto = 1.085853;

% Paso
h = (b - a) / n;

% puntos
x = a:h:b;
y = f(x);

% Aplicar la regla de Simpson 1/3
Int_aprox = y(1) + y(end);
for i = 2:n
    if mod(i,2) == 0
        Int_aprox = Int_aprox + 4*y(i);
    else
        Int_aprox = Int_aprox + 2*y(i);
    end
end
Int_aprox = Int_aprox * (h / 3);

% Calcular la cuarta derivada de f(x) usando symbolic
syms xs
f_sym = exp(-xs^2);
derv4 = diff(f_sym, xs, 4);
f4_func = matlabFunction(derv4);

% Calcular el valor medio de la cuarta derivada en el intervalo
x_eval = linspace(a, b, 1000);
f4_vals = abs(f4_func(x_eval));
f4_prom = mean(f4_vals);

% Estimar el error de truncamiento
Etruncamiento = -( (b - a) * h^4 / 180 ) * f4_prom;

% Error relativo porcentual
error_rel = abs((valor_exacto - Int_aprox) / valor_exacto) * 100;

% Mostrar resultados
fprintf('1. Integral aproximada con Simpson 1/3: %.6f\n', Int_aprox);
fprintf('2. Valor medio de la cuarta derivada: %.6f\n', f4_prom);
fprintf('3. Error de truncamiento estimado: %.6f\n', Etruncamiento);
fprintf('4. Error relativo porcentual: %.2f%%\n', error_rel);
fprintf('       J.Ruano 1010-21-1332   ')
