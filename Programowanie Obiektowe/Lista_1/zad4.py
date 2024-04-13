'''
Cezary Miłek
Zadanie 4 | Lista 1
Python 3.10 zad4.py
'''

from collections import namedtuple

Tabliczka = namedtuple('Tabliczka', ['naglowki_kolumn', 'zawartosc'])

def tabliczka_mnozenia(x1, x2, y1, y2, skok):
    # wyznaczamy liczbę kolumn i wierszy
    kolumny = int((x2 - x1) / skok)
    wiersze = int((y2 - y1) / skok)

    # nagłówki kolumn
    naglowki_kolumn = " " * 8
    for i in range(kolumny):
        naglowki_kolumn += "{:>6.2f}".format(x1 + i * skok)

    # nagłówki wierszy i zawartość
    zawartosc = ""
    for i in range(wiersze):
        y = y1 + i * skok
        zawartosc += "{:>6.2f}: ".format(y)
        for j in range(kolumny):
            x = x1 + j * skok
            zawartosc += "{:>6.2f}".format(x * y)
        zawartosc += "\n"

    return Tabliczka(naglowki_kolumn=naglowki_kolumn, zawartosc=zawartosc)

tabliczka = tabliczka_mnozenia(0.2, 2.3, 0.2, 3.14, 0.3)
print(tabliczka.naglowki_kolumn)
print(tabliczka.zawartosc)
