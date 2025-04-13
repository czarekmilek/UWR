package obliczenia.operand;

import obliczenia.Wyrazenie;
import struktury.Para;
import struktury.ZbiorTablicowy;

public class Zmienna extends Wyrazenie {
    private final String nazwa;
    public static final ZbiorTablicowy zbiorZmiennych = new ZbiorTablicowy(10);

    public Zmienna(String nazwa) {
        this.nazwa = nazwa;
    }

    @Override
    public double oblicz() {
        Para para = zbiorZmiennych.szukaj(nazwa);
        if (para == null) throw new IllegalStateException("Zmienna " + nazwa + " nie zostala zdefiniowana.");
        return para.getWartosc();
    }

    @Override
    public String toString() {
        return nazwa;
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Zmienna && ((Zmienna) obj).nazwa.equals(nazwa);
    }
}
