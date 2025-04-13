package obliczenia.dzialanie.oper2;

import obliczenia.Wyrazenie;

public class Mnoz extends Wyrazenie {
    private final Wyrazenie lewy, prawy;

    public Mnoz(Wyrazenie lewy, Wyrazenie prawy) {
        this.lewy = lewy;
        this.prawy = prawy;
    }

    @Override
    public double oblicz() {
        return lewy.oblicz() * prawy.oblicz();
    }

    @Override
    public String toString() {
        return "(" + lewy + " * " + prawy + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Mnoz)) return false;
        Mnoz other = (Mnoz) obj;
        return lewy.equals(other.lewy) && prawy.equals(other.prawy);
    }
}
