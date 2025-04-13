package obliczenia.dzialanie.oper2;

import obliczenia.Wyrazenie;

public class Odejmij extends Wyrazenie {
    private final Wyrazenie lewy, prawy;

    public Odejmij(Wyrazenie lewy, Wyrazenie prawy) {
        this.lewy = lewy;
        this.prawy = prawy;
    }

    @Override
    public double oblicz() {
        return lewy.oblicz() - prawy.oblicz();
    }

    @Override
    public String toString() {
        return "(" + lewy + " - " + prawy + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Odejmij)) return false;
        Odejmij other = (Odejmij) obj;
        return lewy.equals(other.lewy) && prawy.equals(other.prawy);
    }
}
