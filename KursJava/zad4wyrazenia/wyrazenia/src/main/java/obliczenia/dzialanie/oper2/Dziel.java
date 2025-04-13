package obliczenia.dzialanie.oper2;

import obliczenia.Wyrazenie;

public class Dziel extends Wyrazenie {
    private final Wyrazenie lewy, prawy;

    public Dziel(Wyrazenie lewy, Wyrazenie prawy) {
        this.lewy = lewy;
        this.prawy = prawy;
    }

    @Override
    public double oblicz() {
        double rightValue = prawy.oblicz();

        if (rightValue == 0) {
            throw new ArithmeticException("Division by zero is not allowed.");
        }

        return lewy.oblicz() / rightValue;
    }

    @Override
    public String toString() {
        return "(" + lewy + " / " + prawy + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Dziel)) return false;
        Dziel other = (Dziel) obj;
        return lewy.equals(other.lewy) && prawy.equals(other.prawy);
    }
}
