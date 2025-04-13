package obliczenia.dzialanie.fun1;

import obliczenia.Wyrazenie;

public class Ln extends Wyrazenie {
    private final Wyrazenie argument;

    public Ln(Wyrazenie argument) {
        this.argument = argument;
    }

    @Override
    public double oblicz() {
        return Math.log(argument.oblicz());
    }

    @Override
    public String toString() {
        return "ln(" + argument + ")";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Ln && argument.equals(((Ln) obj).argument);
    }
}
