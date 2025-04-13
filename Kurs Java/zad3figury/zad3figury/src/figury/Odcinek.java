package figury;

public class Odcinek {
    public Punkt start;
    public Punkt end;

    public Odcinek(Punkt start, Punkt end) {
        if (start.getX() == end.getX() && start.getY() == end.getY()) {
            throw new IllegalArgumentException("Punkty początkowy i końcowy muszą być różne.");
        }
        this.start = start;
        this.end = end;
    }

    public void przesun(Wektor v) {
        start.setX(start.getX() + v.dx);
        start.setY(start.getY() + v.dy);
        end.setX(end.getX() + v.dx);
        end.setY(end.getY() + v.dy);
    }

    public void obroc(Punkt p, double kat) {
        double radians = Math.toRadians(kat);
        start = obrocPunkt(start, p, radians);
        end = obrocPunkt(end, p, radians);
    }

    public void odbij(Prosta p) {
        start = odbijPunkt(start, p);
        end = odbijPunkt(end, p);
    }

    private Punkt obrocPunkt(Punkt p, Punkt center, double radians) {
        double x = center.getX() + (p.getX() - center.getX()) * Math.cos(radians) - (p.getY() - center.getY()) * Math.sin(radians);
        double y = center.getY() + (p.getX() - center.getX()) * Math.sin(radians) + (p.getY() - center.getY()) * Math.cos(radians);
        return new Punkt(x, y);
    }

    private Punkt odbijPunkt(Punkt p, Prosta prosta) {
        double a = prosta.a;
        double b = prosta.b;
        double c = prosta.c;
        double d = (a * p.getX() + b * p.getY() + c) / (a * a + b * b);
        double x = p.getX() - 2 * a * d;
        double y = p.getY() - 2 * b * d;
        return new Punkt(x, y);
    }
}
