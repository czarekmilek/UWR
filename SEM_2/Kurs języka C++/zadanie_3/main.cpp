#include "liczba.hpp"
#include <iostream>

using namespace std;

int main() {
    // Tworzymy obiekt liczba domyślnym konstruktorem
    liczba l1;
    cout << "Test konstruktora domyslnego:" << endl;
    cout << "Wartosc l1: " << l1.get_value() << endl;

    // Tworzymy obiekt liczba konstruktorem z argumentem
    liczba l2(13.0);
    cout << "Test konstruktora z argumentem:" << endl;
    cout << "Wartosc l2: " << l2.get_value() << endl;

    // Tworzymy obiekt liczba konstruktorem kopiującym
    liczba l3(l2);
    cout << "Test konstruktora kopiujacego (do l3 z l2):" << endl;
    cout << "Wartosc l3: " << l3.get_value() << endl;

    // Tworzymy obiekt liczba konstruktorem przenoszącym
    liczba l4(move(l3));
    cout << "Test konstruktora przenoszacego (do l4 z l3):" << endl;
    cout << "Wartosc l4: " << l4.get_value() << endl;

    // Przypisanie przez operator kopiujący
    l2.set_value(9);
    cout << "Zmiana wartosci l2 na 9" << endl;
    l1 = l2;
    cout << "Test przypisania przez operator kopiujacy (do l1 z l2):" << endl;
    cout << "Wartosc l1 po skopiowaniu: " << l1.get_value() << endl;

    // Przypisanie przez operator przenoszący
    l3 = move(l4);
    cout << "Test przypisania przez operator przenoszacy (do l3 z l4):" << endl;
    cout << "Wartosc l3 po przeniesieniu: " << l3.get_value() << endl;
    l3.restore_last_value();

    // Ustawianie wartości liczby
    l1.set_value(5.0);
    cout << "Wartosc l1 po set_value: " << l1.get_value() << endl;

    // Przywracanie ostatniej wartości
    cout << "Wartosc l2 przed restore_last_value: " << l2.get_value() << endl;
    l2.restore_last_value();
    cout << "Wartosc l2 po restore_last_value: " << l2.get_value() << endl;

    liczba test;
    test.set_value(10);
    test.set_value(20);
    test.set_value(30);
    test.set_value(40);
    test.set_value(50);

    cout << test.get_value() << endl;
    test.get_history_value(1);
    cout << test.get_value() << endl;
    test.restore_last_value();
    cout << test.get_value() << endl;
    test.restore_last_value();
    cout << test.get_value() << endl;
    return 0;
}
