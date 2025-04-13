package obliczenia.dzialanie.oper1;

import obliczenia.Wyrazenie;

public class Negacja extends Wyrazenie {
    private final Wyrazenie wyrazenie;

    public Negacja(Wyrazenie wyrazenie) {
        this.wyrazenie = wyrazenie;
    }

    @Override
    public double oblicz() {
        return -wyrazenie.oblicz();
    }

    @Override
    public String toString() {
        return "~" + wyrazenie;
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Negacja && wyrazenie.equals(((Negacja) obj).wyrazenie);
    }
}
