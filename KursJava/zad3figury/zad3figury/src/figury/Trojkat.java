package figury;

public class Trojkat {
    public Punkt p1, p2, p3;

    public Trojkat(Punkt p1, Punkt p2, Punkt p3) {
        if (czyWspolliniowe(p1, p2, p3)) {
            throw new IllegalArgumentException("Punkty nie mogą być współliniowe.");
        }
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
    }

    public void przesun(Wektor v) {
        p1.setX(p1.getX() + v.dx);
        p1.setY(p1.getY() + v.dy);
        p2.setX(p2.getX() + v.dx);
        p2.setY(p2.getY() + v.dy);
        p3.setX(p3.getX() + v.dx);
        p3.setY(p3.getY() + v.dy);
    }

    public void obroc(Punkt p, double kat) {
        double radians = Math.toRadians(kat);
        p1 = obrocPunkt(p1, p, radians);
        p2 = obrocPunkt(p2, p, radians);
        p3 = obrocPunkt(p3, p, radians);
    }

    public void odbij(Prosta p) {
        p1 = odbijPunkt(p1, p);
        p2 = odbijPunkt(p2, p);
        p3 = odbijPunkt(p3, p);
    }

    private boolean czyWspolliniowe(Punkt p1, Punkt p2, Punkt p3) {
        return (p2.getY() - p1.getY()) * (p3.getX() - p1.getX()) == (p3.getY() - p1.getY()) * (p2.getX() - p1.getX());
    }

    private Punkt obrocPunkt(Punkt point, Punkt center, double radians) {
        double x = center.getX() + (point.getX() - center.getX()) * Math.cos(radians) - (point.getY() - center.getY()) * Math.sin(radians);
        double y = center.getY() + (point.getX() - center.getX()) * Math.sin(radians) + (point.getY() - center.getY()) * Math.cos(radians);
        return new Punkt(x, y);
    }

    private Punkt odbijPunkt(Punkt point, Prosta prosta) {
        double a = prosta.a;
        double b = prosta.b;
        double c = prosta.c;
        double d = (a * point.getX() + b * point.getY() + c) / (a * a + b * b);
        double x = point.getX() - 2 * a * d;
        double y = point.getY() - 2 * b * d;
        return new Punkt(x, y);
    }
}
