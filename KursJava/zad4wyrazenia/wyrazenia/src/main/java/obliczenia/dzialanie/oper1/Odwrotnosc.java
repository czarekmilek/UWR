package obliczenia.dzialanie.oper1;

import obliczenia.Wyrazenie;

public class Odwrotnosc extends Wyrazenie {
    private final Wyrazenie wyrazenie;

    public Odwrotnosc(Wyrazenie wyrazenie) {
        this.wyrazenie = wyrazenie;
    }

    @Override
    public double oblicz() {
        return 1.0 / wyrazenie.oblicz();
    }

    @Override
    public String toString() {
        return "(! " + wyrazenie + ")";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Odwrotnosc && wyrazenie.equals(((Odwrotnosc) obj).wyrazenie);
    }
}
