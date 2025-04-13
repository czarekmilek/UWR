import java.awt.*;

public class Kreska {
    protected Point poczatek, koniec;
    protected Color kolor;

    public Kreska(Point poczatek, Point koniec, Color kolor) {
        this.poczatek = poczatek;
        this.koniec = koniec;
        this.kolor = kolor;
    }

    public void draw(Graphics g) {
        g.setColor(kolor);
        g.drawLine(poczatek.x, poczatek.y, koniec.x, koniec.y);
    }
}
