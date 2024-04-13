#include <iostream>
#include <cstdint>
#include <cassert>
#include "ref.hpp"

#ifndef tab_bit_
#define tab_bit_

using namespace std;

class ref;

class tab_bit {
    typedef uint64_t slowo; // komorka w tablicy
    static const int rozmiarSlowa; // rozmiar slowa w bitach
    friend istream& operator >> (istream& we, tab_bit& tb);
    friend ostream& operator << (ostream& wy, const tab_bit& tb);
    friend class ref; // klasa pomocnicza do adresowania bitów
protected:
    int dl; // liczba bitów
    slowo* tab; // tablica bitów
public:
    explicit tab_bit(int rozm); // wyzerowana tablica bitow [0...rozm]
    explicit tab_bit(slowo tb); // tablica bitów [0...rozmiarSlowa]
    tab_bit(initializer_list<bool> list);
    tab_bit(const tab_bit& tb); // konstruktor kopiujący
    tab_bit(tab_bit&& tb); // konstruktor przenoszący
    tab_bit& operator = (const tab_bit& tb); // przypisanie kopiujące
    tab_bit& operator = (tab_bit&& tb); // przypisanie przenoszące
    ~tab_bit(); // destruktor
private:
    bool czytaj(int i) const; // metoda pomocnicza do odczytu bitu
    bool pisz(int i, bool b); // metoda pomocnicza do zapisu bitu
public:
    bool operator[] (int i) const; // indeksowanie dla stałych tablic bitowych
    ref operator[] (int i); // indeksowanie dla zwykłych tablic bitowych
    inline int rozmiar() const; // rozmiar tablicy w bitach
public:
    tab_bit operator|(const tab_bit& tb) const;
    tab_bit operator|=(const tab_bit& tb);
    tab_bit operator&(const tab_bit& tb) const;
    tab_bit operator&=(const tab_bit& tb);
    tab_bit operator^(const tab_bit& tb) const;
    tab_bit operator^=(const tab_bit& tb);
    tab_bit operator!() const;
};
#endif