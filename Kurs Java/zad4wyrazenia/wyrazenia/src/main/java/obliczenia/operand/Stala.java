package obliczenia.operand;

import obliczenia.Wyrazenie;

public class Stala extends Wyrazenie {
    public static final Stala PI = new Stala(Math.PI);
    public static final Stala E = new Stala(Math.E);
    private final double wartosc;

    private Stala(double wartosc) {
        this.wartosc = wartosc;
    }

    @Override
    public double oblicz() {
        return wartosc;
    }

    @Override
    public String toString() {
        return this == PI ? "π" : "e";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Stala && ((Stala) obj).wartosc == wartosc;
    }
}
