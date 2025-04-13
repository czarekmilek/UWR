package obliczenia.dzialanie.fun1;

import obliczenia.Wyrazenie;

public class Sin extends Wyrazenie {
    private final Wyrazenie argument;

    public Sin(Wyrazenie argument) {
        this.argument = argument;
    }

    @Override
    public double oblicz() {
        return Math.sin(argument.oblicz());
    }

    @Override
    public String toString() {
        return "sin(" + argument + ")";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Sin && argument.equals(((Sin) obj).argument);
    }
}
