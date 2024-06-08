% Dane
n = 339746;
k = mod(n, 10);
m = mod((n - k) / 10, 10);
lambda = k + m + 1;
a_values = [3, 4, 6, 10];

% Wartość dokładna
exact_value = @(lambda, a) exp(-lambda^2 * a);

% Markov
markov = @(lambda, a) 1 / (lambda^2 * a);

% Chebyshev
chebyshev = @(lambda, a) 1 / (lambda^2 * (lambda * a - 1 / lambda)^2);

% Chernoff
chernoff = @(lambda, a) lambda^2 * a * exp(-lambda^2 * a + 1);

for i = 1:length(a_values)
    a = a_values(i);
    disp(['For a = ', num2str(a), ':']);
    disp(['Exact Value: ', num2str(exact_value(lambda, a))]);
    disp(['Markov''s Estimation: ', num2str(markov(lambda, a))]);
    disp(['Chebyshev''s Estimation: ', num2str(chebyshev(lambda, a))]);
    disp(['Chernoff''s Estimation: ', num2str(chernoff(lambda, a))]);
    disp(' ');
end
