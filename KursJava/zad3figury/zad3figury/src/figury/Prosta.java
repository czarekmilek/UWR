package figury;

public class Prosta {
    public final double a, b, c;

    public Prosta(double a, double b, double c) {
        if (a == 0 && b == 0) {
            throw new IllegalArgumentException("Punkty a i b nie mogą być jednocześnie zerem.");
        }
        this.a = a;
        this.b = b;
        this.c = c;
    }

    public static Prosta przesun(Prosta p, Wektor v) {
        return new Prosta(p.a, p.b, p.c - p.a * v.dx - p.b * v.dy);
    }

    public static boolean czyRownolegle(Prosta p1, Prosta p2) {
        return p1.a * p2.b == p1.b * p2.a;
    }

    public static boolean czyProstopadle(Prosta p1, Prosta p2) {
        return p1.a * p2.a + p1.b * p2.b == 0;
    }

    public static Punkt punktPrzeciecia(Prosta p1, Prosta p2) {
        double determinant = p1.a * p2.b - p2.a * p1.b;
        if (determinant == 0) {
            throw new IllegalArgumentException("Proste są równoległe, brak punktu przecięcia.");
        }
        double x = (p2.c * p1.b - p1.c * p2.b) / determinant;
        double y = (p1.c * p2.a - p2.c * p1.a) / determinant;
        return new Punkt(x, y);
    }
}
