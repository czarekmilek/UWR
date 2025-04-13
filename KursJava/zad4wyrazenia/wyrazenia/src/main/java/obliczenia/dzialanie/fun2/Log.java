package obliczenia.dzialanie.fun2;

import obliczenia.Wyrazenie;

public class Log extends Wyrazenie {
    private final Wyrazenie podstawa;
    private final Wyrazenie argument;

    public Log(Wyrazenie podstawa, Wyrazenie argument) {
        this.podstawa = podstawa;
        this.argument = argument;
    }

    @Override
    public double oblicz() {
        return Math.log(argument.oblicz()) / Math.log(podstawa.oblicz());
    }

    @Override
    public String toString() {
        return "log(" + podstawa + ", " + argument + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Log)) return false;
        Log other = (Log) obj;
        return podstawa.equals(other.podstawa) && argument.equals(other.argument);
    }
}
