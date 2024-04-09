#include <iostream>
#include <cmath>

// Definicja funkcji f(x)
double f(double x) {
    return pow(x, 4) - log(x + 4);
}

int main() {
    double a0 = -1.1; // Początkowa wartość a
    double b0 = -0.8; // Początkowa wartość b
    double epsilon = 1e-6; // Dokładność

    for (int n = 1; n <= 25; n++) {
        double c = (a0 + b0) / 2.0; // Środek przedziału
        double error = (b0 - a0) / pow(2.0, n+1); // Błąd przybliżenia

        std::cout << "Iteration " << n << ":\n";
        std::cout << "a" << n << " = " << a0 << "\n";
        std::cout << "b" << n << " = " << b0 << "\n";
        std::cout << "c" << n << " = " << c << "\n";
        std::cout << "f(c" << n << ") = " << f(c) << "\n";
        std::cout << "Error |e" << n << "| = " << error << "\n";
        std::cout << "Error estimation: " << fabs(f(c)) << "\n";
        std::cout << "Error difference: " << fabs(error - fabs(f(c))) << "\n" ;
        std::cout << "-----------------------------------------\n";

        if (f(c) * f(b0) < 0) {
            a0 = c;
        } else {
            b0 = c;
        }
    }

    return 0;
}
