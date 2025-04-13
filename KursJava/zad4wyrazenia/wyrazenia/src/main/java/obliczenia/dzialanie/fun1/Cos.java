package obliczenia.dzialanie.fun1;

import obliczenia.Wyrazenie;

public class Cos extends Wyrazenie {
    private final Wyrazenie argument;

    public Cos(Wyrazenie argument) {
        this.argument = argument;
    }

    @Override
    public double oblicz() {
        return Math.cos(argument.oblicz());
    }

    @Override
    public String toString() {
        return "cos(" + argument + ")";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Cos && argument.equals(((Cos) obj).argument);
    }
}
