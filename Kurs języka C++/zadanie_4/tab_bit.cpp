#include "tab_bit.hpp"

using namespace std;

const int tab_bit::rozmiarSlowa = sizeof(tab_bit::slowo) * 8;

// operator wczytania z strumienia
/* strumień danych wejściowych (we)
*  referencja do obiektu tab_bit (tb), który ma zostać wczytany*/
istream& operator>>(istream& we, tab_bit& tb)
{
    string str;
    we >> str;
    if (str.length() > tb.dl)
        throw invalid_argument("Zbyt dlugi lancuch wejsciowy.");
    for (int i = 0; i < str.length(); i++)
    {
        if (str[i] == '0')
            tb.pisz(i, false);
        else if (str[i] == '1')
            tb.pisz(i, true);
        else
            //jeżeli znak jest inny niż '0' lub '1'
            throw invalid_argument("Nieprawidlowy znak wejsciowy.");
    }
    return we;
}

// operator wypisania do strumienia
// strumień danych wyjściowych (wy)
// jest const - nie modyfikuje obiektu tb
ostream& operator<<(ostream& wy, const tab_bit& tb)
{
    // wypisujemy kolejne bity do strumienia wyjściowego
    for (int i = 0; i < tb.dl; i++)
        wy << tb.czytaj(i);
    return wy;
}


// wyzerowana tablica bitow [0...rozm]
tab_bit::tab_bit(int rozm) {
    dl = rozm;
    int liczbaSlow = (rozm + rozmiarSlowa - 1) / rozmiarSlowa;
    tab = new slowo[liczbaSlow];
    for (int i = 0; i < liczbaSlow; i++) {
        tab[i] = 0;
    }
}

// tablica bitów [0...rozmiarSlowa]
tab_bit::tab_bit(slowo tb) {
    //rozmiar jest stały
    dl = rozmiarSlowa;
    tab = new slowo[1];
    tab[0] = tb;
}

tab_bit::tab_bit(initializer_list<bool> list)
{
    dl=list.size();
    tab = new slowo[dl+1];
    int i = 0;
    for(auto x : list)
    {
        pisz(i,x);
        i++;
    }
}

// konstruktor kopiujący
tab_bit::tab_bit(const tab_bit& tb) {
    dl = tb.dl;
    int n = (dl + rozmiarSlowa - 1) / rozmiarSlowa;
    tab = new slowo[n];
    for (int i = 0; i < n; i++) {
        tab[i] = tb.tab[i];
    }
}

// konstruktor przenoszący
tab_bit::tab_bit(tab_bit&& tb) {
    dl = tb.dl;
    tab = tb.tab;
    tb.dl = 0;
    tb.tab = nullptr;
}

// przypisanie kopiujące
tab_bit& tab_bit::operator=(const tab_bit& tb)
{
    if (this == &tb)
        return *this;
    // zwolnij aktualnie używaną pamięć
    delete[] tab;
    // zajmij nową pamięć
    dl = tb.dl;
    tab = new slowo[(dl + rozmiarSlowa - 1) / rozmiarSlowa];
    // skopiuj dane
    for (int i = 0; i < dl; ++i)
        pisz(i, tb.czytaj(i));

    return *this;
}

// przypisanie przenoszące
tab_bit& tab_bit::operator=(tab_bit&& tb)
{
    if (this == &tb)
        return *this;
    // zwolnij aktualnie używaną pamięć
    delete[] tab;
    // przypisz nowe dane
    dl = tb.dl;
    tab = tb.tab;
    // wyzeruj stan obiektu źródłowego
    tb.dl = 0;
    tb.tab = nullptr;

    return *this;
}


// destruktor
tab_bit::~tab_bit() {
    if (tab != nullptr)
    {
        delete[] tab;
        tab = nullptr;
    }
}


bool tab_bit::czytaj(int i) const {
    int slowo_index = i / rozmiarSlowa;
    int bit_index = i % rozmiarSlowa;
    return (tab[slowo_index] & (slowo(1) << bit_index)) != 0;
}
/*
bool tab_bit::czytaj(int i) const {
    int slowo_index = i / rozmiarSlowa;
    int bit_index = i % rozmiarSlowa;
    return (tab[slowo_index] >> bit_index) & 1;
}
 */

bool tab_bit::pisz(int i, bool b) {
    int slowo_index = i / rozmiarSlowa;
    int bit_index = i % rozmiarSlowa;
    if (b) {
        tab[slowo_index] |= (slowo(1) << bit_index);
    }
    else {
        tab[slowo_index] &= ~(slowo(1) << bit_index);
    }
    return b;
}
/*
bool tab_bit::pisz(int i, bool b) {
    int slowo_index = i / rozmiarSlowa;
    int bit_index = i % rozmiarSlowa;
    if (b) {
        tab[slowo_index] |= (1 << bit_index);
    }
    else {
        tab[slowo_index] &= ~(1 << bit_index);
    }
    return b;
}
 */


//implementacja operatora[] dla stalych tablic bitow
bool tab_bit::operator[](int i) const {
    return czytaj(i);
}


//implementacja operatora[] dla niestalych tablic bitow
ref tab_bit::operator[](int i) {
    return ref(*this, i);
}


// rozmiar tablicy
inline int tab_bit::rozmiar() const {
    return dl;
}

// operatory bitowe: | i |=, & i &=, ^ i ^= oraz !


//operator| to alternatywa bitowa (OR)
tab_bit tab_bit::operator|(const tab_bit& tb) const
{
    assert(dl == tb.dl);
    tab_bit result(dl);

    for(int i = 0; i < dl; ++i) {
        //ustawia bit wynikowy na 1, jeśli co najmniej jeden z bitów jest ustawiony na 1
        result.pisz(i, czytaj(i) || tb.czytaj(i));
    }

    return result;
}

//operator|= to alternatywa bitowa z przypisaniem (OR-assign)
tab_bit tab_bit::operator|=(const tab_bit& tb)
{
    assert(dl == tb.dl);

    for (int i = 0; i < dl; ++i) {
        pisz(i, czytaj(i) || tb.czytaj(i));
    }

    return *this;
}

//operator& to koniunkcja bitowa (AND)
tab_bit tab_bit::operator&(const tab_bit& tb) const
{
    assert(dl == tb.dl);
    tab_bit result(dl);

    for (int i = 0; i < dl; ++i) {
        result.pisz(i, czytaj(i) && tb.czytaj(i));
    }

    return result;
}

//operator&= to koniunkcja bitowa z przypisaniem (AND-assign)
tab_bit tab_bit::operator&=(const tab_bit& tb)
{
    assert(dl == tb.dl);
    for (int i = 0; i < dl; ++i) {
        pisz(i, czytaj(i) && tb.czytaj(i));
    }
    return *this;
}

//operator^ to różnica symetryczna (XOR)
tab_bit tab_bit::operator^(const tab_bit& tb) const
{
    assert(dl == tb.dl);
    tab_bit result(dl);

    for (int i = 0; i < dl; ++i) {
        result.pisz(i, czytaj(i) ^ tb.czytaj(i));
    }

    return result;
}

//operator^= to różnica symetryczna z przypisaniem (XOR-assign)
tab_bit tab_bit::operator^=(const tab_bit& tb)
{
    assert(dl == tb.dl);

    for (int i = 0; i < dl; ++i) {
        pisz(i, czytaj(i) ^ tb.czytaj(i));
    }

    return *this;
}

//operator! to negacja logiczna (NOT)
tab_bit tab_bit::operator!() const
{
    tab_bit result(dl);

    for (int i = 0; i < dl; ++i) {
        result.pisz(i, !czytaj(i));
    }

    return result;
}
