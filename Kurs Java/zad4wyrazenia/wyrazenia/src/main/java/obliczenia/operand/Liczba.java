package obliczenia.operand;

import obliczenia.Wyrazenie;

public class Liczba extends Wyrazenie {
    private final double wartosc;

    public Liczba(double wartosc) {
        this.wartosc = wartosc;
    }

    @Override
    public double oblicz() {
        return wartosc;
    }

    @Override
    public String toString() {
        return Double.toString(wartosc);
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Liczba && ((Liczba) obj).wartosc == wartosc;
    }
}
