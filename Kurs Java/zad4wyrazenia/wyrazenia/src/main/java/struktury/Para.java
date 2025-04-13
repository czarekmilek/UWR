package struktury;

public class Para implements Cloneable, Comparable<Para> {
    public final String klucz;
    private double wartosc;

    public Para(String klucz, double wartosc) {
        if (klucz == null || !klucz.matches("[a-z]+")) {
            throw new IllegalArgumentException("Klucz musi byc niepustym ciagiem malych liter.");
        }
        this.klucz = klucz;
        this.wartosc = wartosc;
    }

    public double getWartosc() {
        return wartosc;
    }

    public void setWartosc(double wartosc) {
        this.wartosc = wartosc;
    }

    @Override
    public String toString() {
        return "(" + klucz + ", " + wartosc + ")";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj instanceof Para) {
            Para para = (Para) obj;
            return klucz.equals(para.klucz);
        }
        return false;
    }

    @Override
    public int compareTo(Para p) {
        return klucz.compareTo(p.klucz);
    }

    @Override
    protected Para clone() {
        return new Para(this.klucz, this.wartosc);
    }
}
