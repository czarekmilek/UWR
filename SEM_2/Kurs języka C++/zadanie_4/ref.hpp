#pragma once
#include "tab_bit.hpp"

using namespace std;

class ref {
    friend class tab_bit;
    tab_bit& tablica; // referencja do tablicy bitów, której element adresujemy
    int indeks; // indeks bitu, który adresujemy
    ref(tab_bit& tb, int i); // konstruktor klasy pomocniczej
public:
    operator bool() const; // konwersja na bool
    ref& operator=(const ref& other); // przypisanie wartości bool
    ref& operator=(bool b); // przypisanie wartości bool

};