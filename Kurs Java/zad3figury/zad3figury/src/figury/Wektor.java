package figury;

public class Wektor {
    public final double dx, dy;

    public Wektor(double dx, double dy) {
        this.dx = dx;
        this.dy = dy;
    }

    public static Wektor dodaj(Wektor v1, Wektor v2) {
        return new Wektor(v1.dx + v2.dx, v1.dy + v2.dy);
    }
}
