#include "wymierna.hpp"
using namespace obliczenia;
using namespace std;

int main() {
    cout << "liczba1 = wymierna(2359348, 99900) = ";
    wymierna liczba1 = wymierna(2359348, 99900);
    cout << liczba1 << endl;

    cout << "liczba2 = wymierna(12) = ";
    wymierna liczba2 = wymierna(12);
    cout << liczba2 << endl;

    cout << "liczba1 + liczba2 = ";
    wymierna liczba3 = liczba1 + liczba2;
    cout << liczba3 << endl;

    cout << "double(liczba1) = ";
    cout << double(liczba1) << endl;

    cout << "int(liczba1) = ";
    cout << int(liczba1) << endl;

    cout << "-liczba2 = ";
    cout << -liczba2 << endl;

    cout << "!liczba2 = ";
    cout << !liczba2 << endl;

    cout << "liczba1/=liczba2 -> liczba1 = ";
    liczba1/=liczba2;
    cout << liczba1 << endl;

    cout << "licznik liczba1 = ";
    cout << liczba1.getLicznik() << endl;

    cout << "mianownik liczba1 = ";
    cout << liczba1.getMianownik() << endl;

    cout << "1/7 = ";
    wymierna liczba4 = wymierna(1, 7);
    cout << liczba4;
    return 1;
}
