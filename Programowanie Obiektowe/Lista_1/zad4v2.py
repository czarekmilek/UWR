class TabliczkaMnozenia:
    def __init__(self, x1, x2, y1, y2, skok):
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2
        self.skok = skok

    def _naglowki_kolumn(self):
        naglowki = " " * 8
        for i in range(self.kolumny):
            naglowki += "{:>6.2f}".format(self.x1 + i * self.skok)
        return naglowki

    def _zawartosc(self):
        zawartosc = ""
        for i in range(self.wiersze):
            y = self.y1 + i * self.skok
            zawartosc += "{:>6.2f}: ".format(y)
            for j in range(self.kolumny):
                x = self.x1 + j * self.skok
                zawartosc += "{:>6.2f}".format(x * y)
            zawartosc += "\n"
        return zawartosc

    def drukuj(self):
        # wyznaczamy liczbę kolumn i wierszy
        self.kolumny = int((self.x2 - self.x1) / self.skok)
        self.wiersze = int((self.y2 - self.y1) / self.skok)

        # nagłówki kolumn
        naglowki_kolumn = self._naglowki_kolumn()
        print(naglowki_kolumn)

        # nagłówki wierszy i zawartość
        zawartosc = self._zawartosc()
        print(zawartosc)


# przykładowe użycie
tabliczka = TabliczkaMnozenia(0.2, 2.3, 0.2, 3.14, 0.3)
tabliczka.drukuj()
