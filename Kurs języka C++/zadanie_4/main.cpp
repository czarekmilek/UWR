#include <iostream>
#include "tab_bit.hpp"

using namespace std;

int main()
{
    //FRAGMENT, KTORY POWINIEN SIE KOMPILOWAC
    tab_bit t(46); // tablica 46-bitowa (zainicjalizowana zerami)
    cout << "Tablica t: " << t << endl;
    tab_bit u(45ull); // tablica 64-bitowa (sizeof(uint64_t)*8)
    tab_bit test(100);
    cout << "Tablica p: " << test << endl;
    cout << "Tablica u: " << u << endl;
    tab_bit v(t); // tablica 46-bitowa (skopiowana z t)
    cout << "Tablica v: " << v << endl;

//    tab_bit x(8);
//    x[0] = x[2] = x[3] = x[7] = 1;
//    tab_bit w(x); // tablica 8-bitowa (przeniesiona)
//    cout << "Tablica w: " << w << endl;

    tab_bit w({1, 0, 1, 1, 0, 0, 0, 1}); // tablica 8-bitowa (przeniesiona)
    cout << "Tablica w: " << w << endl;

    v[0] = 1; // ustawienie bitu 0-go bitu na 1
    cout << "Tablica v po v[0] = 1: " << v << endl;
    t[45] = true; // ustawienie bitu 45-go bitu na 1
    cout << "Tablica t po t[45] = true: " << t << endl; // wysietlenie zawartości tablicy bitów na ekranie
    bool b = v[1]; // odczytanie bitu 2-go
    cout << "Wartosc drugiego bitu tablicy v: " << b << endl;
    bool c = v[0]; // odczytanie bitu 1-go
    cout << "Wartosc pierwszego bitu tablicy v: " << c << endl;
    u[63] = 1;
    u[45] = u[46] = u[63]; // przepisanie bitu 63-go do bitow 45-go i 46-go
    cout << "Tablica u po u[45] = i[46] = u[63]: " << u << endl;

    //RESZTA TESTOW
    tab_bit t1(4);
    t1[0] = true;
    t1[1] = false;
    t1[2] = true;
    t1[3] = false;

    tab_bit t2(4);
    t2[0] = true;
    t2[1] = true;
    t2[2] = false;
    t2[3] = false;

// Test funkcji operator|()
//operator| to alternatywa bitowa (OR)
    tab_bit t3 = t1 | t2;
    cout << "t1 | t2 = " << t3 << endl; // spodziewane wyjście: 1011

// Test funkcji operator|=()
//operator|= to alternatywa bitowa z przypisaniem (OR-assign)
    t1 |= t2;
    cout << "t1 |= t2 = " << t1 << endl; // spodziewane wyjście: 1011

// Test funkcji operator&()
//operator& to koniunkcja bitowa (AND)
    tab_bit t4 = t1 & t2;
    cout << "t1 & t2 = " << t4 << endl; // spodziewane wyjście: 1000

// Test funkcji operator&=()
//operator&= to koniunkcja bitowa z przypisaniem (AND-assign)
    t1 &= t2;
    cout << "t1 &= t2 = " << t1 << endl; // spodziewane wyjście: 1000

// Test funkcji operator^()
//operator^ to różnica symetryczna (XOR)
    tab_bit t5 = t1 ^ t2;
    cout << "t1 ^ t2 = " << t5 << endl; // spodziewane wyjście: 0011

// Test funkcji operator^=()
//operator^= to różnica symetryczna z przypisaniem (XOR-assign)
    t1 ^= t2;
    cout << "t1 ^= t2 = " << t1 << endl; // spodziewane wyjście: 0011

// Test funkcji operator!()
//operator! to negacja logiczna (NOT)
    tab_bit t6 = !t1;
    cout << "!t1 = " << t6 << endl; // spodziewane wyjście: 1100

    //test wczytania ze strumienia
    int n;
    cout << "Podaj dlugosc tablicy: ";
    cin >> n;
    tab_bit wejscie(n);
    cout << "Podaj ciag bitow (0/1): ";
    cin >> wejscie;
    cout << "Wprowadzono ciag bitow: " << wejscie << endl;
}