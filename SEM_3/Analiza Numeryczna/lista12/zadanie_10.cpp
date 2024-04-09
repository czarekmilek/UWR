#include <iostream>
#include <cmath>

using namespace std;

double f1(double x)
{
    return 2024 * pow(x, 8) - 1977 * pow(x, 4) - 1981;
}

double f2(double x)
{
    return 1 / (1 + x * x);
}

double f3(double x)
{
    return sin(5 * x - M_PI / 3);
}

double calka(double a, double b, double h, double (*f)(double))
{
    double suma = 0.5 * (f(a) + f(b));
    for (double i = a; i < b; i = i + h)
    {
        suma = suma + f(i);
    }
    return suma;
}

double oblicz_wynik(double a, double b, double (*f)(double))
{
    int n = 16;
    double tabT[n + 1];

    //wzor trapezow
    for (int k = 0; k <= n; k++)
    {
        double h = (b - a) / pow(2, k);
        tabT[k] = h * calka(a, b, h, f);
    }

    for (int m = 1; m <= n; m++)
    {
        for (int k = n - m; k >= 0; k--)
        {
            tabT[k + 1] = (pow(4, m) * tabT[k + 1] - tabT[k]) / (pow(4, m) - 1);
        }
    }
    return tabT[n];
}

int main()
{
    cout << oblicz_wynik(-3, 2, f1) << endl;
    cout << oblicz_wynik(-3, 3, f2) << endl;
    cout << oblicz_wynik(-3 * M_PI,  M_PI / 6, f3) << endl;

    return 0;
}