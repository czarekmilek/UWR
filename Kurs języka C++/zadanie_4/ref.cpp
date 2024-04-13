#include "ref.hpp"

ref::ref(tab_bit& tb, int i):tablica(tb), indeks(i){}

ref::operator bool() const {
    return tablica.czytaj(indeks);
}

ref& ref::operator=(bool b) {
    tablica.pisz(indeks, b);
    return *this;
}

ref& ref::operator=(const ref& other) {
    // sprawdz przypisanie do samej siebie
    if (this == &other) {
        return *this;
    }

    //skopiuj wartosc innego objektu ref
    bool value = static_cast<bool>(other);

    //przypisz wartosc do referencjowanego bita w objekcie tab_bit
    tablica.pisz(indeks, value);

    //zwroc referencje na objekt ref
    return *this;
}