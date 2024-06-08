fprintf('Rozkład t-Studenta\n');

% -------------------------------------------
% Metoda Romberga

function result = romberg_method(f, a, b, n)
    % ROMBERG_METHOD - Oblicza wartość całki danej funkcji, używając metody Romberga
    %   f:      Całkowana funkcja.
    %   a, b:   Granice całkowania.
    %   n:      Liczba iteracji metody.
    
    % Rozmiar skoku
    h = (b - a) / 2^(n-1);

    % Pierwsza aproksymacja całki z metody trapezów
    R = trapezoidal_rule(f, a, b, h);

    % Kolejne aproksymacje
    for i = 2:n
        % Zmniejszenie kroku
        h = h / 2;
        R = romberg_update(R, i);
    end

    result = R;
end

function result = trapezoidal_rule(f, a, b, h)
    % TRAPEZOIDAL_RULE - Oblicza przybliżenie całki, korzystając z reguły trapezów.
    %   f:      Funkcja całkowana.
    %   a, b:   Granice całkowania.
    %   h:      Rozmiar kroku.

    % Wartości na krańcach przedziałów
    fa = f(a);
    fb = f(b);

    % Wartości w punktach pośrednich
    x = a + h:h:b - h;
    fx = f(x);

    % Wzór trapezów
    result = h * (((fa + fb) / 2) + sum(fx));
end

function result = romberg_update(prev, k)
    % ROMBERG_UPDATE - Oblicza kolejną aproksymację.
    %   prev:    Poprzednia aproksymacja.
    %   k:       Indeks obecnej iteracji.

    % Ze wzoru
    result = (4^(k-1) * prev - circshift(prev, [0 1])) / (4^(k-1) - 1);
end

% -------------------------------------------
% Funkcja Gamma-Eulera
function result = gamma_romberg(x)
    % GAMMA_ROMBERG - Oblicza wartość funkcji Gamma dla danej liczby x, używając metody Romberga.
    %   x:       Liczba dla której obliczana jest funkcja Gamma.

    f = @(t) t.^(x-1) .* exp(-t);
    global n; % Liczba iteracji metody Romberga.

    result = romberg_method(f, 0, 10000, n);
end

% -------------------------------------------
% Definicja głównej funkcji

function pdf_value = tpdf_manual(x, k)
    % Licznik
    numerator = gamma_romberg((k + 1) / 2);

    % Mianownik
    denominator = sqrt(pi * k) * gamma_romberg(k / 2);

    % Wyrazenie po ulamku
    expression = (1 + (x .^ 2) ./ k) .^ (-(k + 1) / 2);

    % Finalna wartosc
    pdf_value = numerator / denominator * expression;

end

% -------------------------------------------
% Finalna funkcja

function result = tcdf_romberg(x, k)
    % TCDF_ROMBERG - Oblicza wartość dystrybuanty dla podanego argumentu x.
    %   x:       Punkt, w którym obliczamy wartość dystrybuanty.

    % Definicja funkcji do całkowania
    f = @(t) tpdf_manual(t, k);

    % Granice całkowania
    global start; % -inf - pierwsza granica
    % x - druga granica

    % Liczba iteracji metody Romberga
    global n;

    % Obliczenie wyniku całki
    result = romberg_method(f, start, x, n);
end

% -------------------------------------------

function main()
    fprintf('===================================== \n');
    % Kilka prostych testów

    % Przedział całkowania [start, x]
    global start; 
    start = -10000; % -inf
    x = 2.1;
    % Liczba kroków
    global n;
    n = 20;
    % Liczba stopni swobody
    global k;
    k = 30;

    result = tcdf_romberg(x, k);
    good_result = tcdf(x, k);

    fprintf('\nTest 1\n');
    fprintf('-----------------');
    fprintf('\nx: %.3f', x);
    fprintf('\nk: %.0f', k);
    fprintf('\n\nWynik metody Romberga:    | %.11f', result);
    fprintf('\nWynik funkcji wbudowanej: | %.11f\n', good_result);
    fprintf('=================\n');

    x = 1.1;
    k = 20;

    result = tcdf_romberg(x, k);
    good_result = tcdf(x, k);

    fprintf('\nTest 2\n');
    fprintf('-----------------');
    fprintf('\nx: %.3f', x);
    fprintf('\nk: %.0f', k);
    fprintf('\n\nWynik metody Romberga:    | %.11f', result);
    fprintf('\nWynik funkcji wbudowanej: | %.11f\n', good_result);
    fprintf('=================\n');

    x = 0.666;
    k = 10;

    result = tcdf_romberg(x, k);
    good_result = tcdf(x, k);

    fprintf('\nTest 3\n');
    fprintf('-----------------');
    fprintf('\nx: %.3f', x);
    fprintf('\nk: %.0f', k);
    fprintf('\n\nWynik metody Romberga:    | %.11f', result);
    fprintf('\nWynik funkcji wbudowanej: | %.11f\n', good_result);
    fprintf('=================\n');

    x = 1.125;
    k = 15;

    result = tcdf_romberg(x, k);
    good_result = tcdf(x, k);

    fprintf('\nTest 4\n');
    fprintf('-----------------');
    fprintf('\nx: %.3f', x);
    fprintf('\nk: %.0f', k);
    fprintf('\n\nWynik metody Romberga:    | %.11f', result);
    fprintf('\nWynik funkcji wbudowanej: | %.11f\n', good_result);
    fprintf('=================\n');

    x = 2.89;
    k = 17;

    result = tcdf_romberg(x, k);
    good_result = tcdf(x, k);

    fprintf('\nTest 5\n');
    fprintf('-----------------');
    fprintf('\nx: %.3f', x);
    fprintf('\nk: %.0f', k);
    fprintf('\n\nWynik metody Romberga:    | %.11f', result);
    fprintf('\nWynik funkcji wbudowanej: | %.11f\n', good_result);
    fprintf('=================\n');

end

main();

