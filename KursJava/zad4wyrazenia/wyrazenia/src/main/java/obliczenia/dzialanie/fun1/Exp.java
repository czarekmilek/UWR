package obliczenia.dzialanie.fun1;

import obliczenia.Wyrazenie;

public class Exp extends Wyrazenie {
    private final Wyrazenie argument;

    public Exp(Wyrazenie argument) {
        this.argument = argument;
    }

    @Override
    public double oblicz() {
        return Math.exp(argument.oblicz());
    }

    @Override
    public String toString() {
        return "exp(" + argument + ")";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Exp && argument.equals(((Exp) obj).argument);
    }
}
