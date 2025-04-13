package obliczenia.dzialanie.fun2;

import obliczenia.Wyrazenie;

public class Pot extends Wyrazenie {
    private final Wyrazenie podstawa;
    private final Wyrazenie wykładnik;

    public Pot(Wyrazenie podstawa, Wyrazenie wykładnik) {
        this.podstawa = podstawa;
        this.wykładnik = wykładnik;
    }

    @Override
    public double oblicz() {
        return Math.pow(podstawa.oblicz(), wykładnik.oblicz());
    }

    @Override
    public String toString() {
        return "(" + podstawa + "^" + wykładnik + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Pot)) return false;
        Pot other = (Pot) obj;
        return podstawa.equals(other.podstawa) && wykładnik.equals(other.wykładnik);
    }
}
