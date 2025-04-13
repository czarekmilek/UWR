import figury.*;
import org.junit.Assert;
import org.junit.Test;

public class TestFigury {

    @Test
    public void testPunktInit() {
        Punkt p = new Punkt(3.5, -2.1);
        Assert.assertEquals(3.5, p.getX(), 1e-9);
        Assert.assertEquals(-2.1, p.getY(), 1e-9);
    }

    @Test
    public void testWektorDodawanie() {
        Wektor v1 = new Wektor(1, 2);
        Wektor v2 = new Wektor(3, 4);
        Wektor result = Wektor.dodaj(v1, v2);
        Assert.assertEquals(4, result.dx, 1e-9);
        Assert.assertEquals(6, result.dy, 1e-9);
    }

    @Test
    public void testProstaRownolegle() {
        Prosta p1 = new Prosta(1, -1, 0);
        Prosta p2 = new Prosta(2, -2, 0);
        Assert.assertTrue(Prosta.czyRownolegle(p1, p2));

        Prosta p3 = new Prosta(3, -2, 0);
        Assert.assertFalse(Prosta.czyRownolegle(p1, p3));
    }

    @Test
    public void testProstaProstopadle() {
        Prosta p1 = new Prosta(1, 1, 0);
        Prosta p2 = new Prosta(1, -1, 0);
        Assert.assertTrue(Prosta.czyProstopadle(p1, p2));

        Prosta p3 = new Prosta(3, -2, 0);
        Assert.assertFalse(Prosta.czyProstopadle(p1, p3));
    }

    @Test
    public void testProstaPrzeciecie() {
        Prosta p1 = new Prosta(1, -1, 0);
        Prosta p2 = new Prosta(1, 1, -2);
        Punkt intersection = Prosta.punktPrzeciecia(p1, p2);
        Assert.assertEquals(1, intersection.getX(), 1e-9);
        Assert.assertEquals(1, intersection.getY(), 1e-9);

        Assert.assertThrows(IllegalArgumentException.class, () -> {
            Punkt notIntersection = Prosta.punktPrzeciecia(p1, p1);
        });
    }

    @Test
    public void testProstaPrzesuniecie() {
        Prosta p1 = new Prosta(1, -1, 0);
        Wektor v1 = new Wektor(3, -9);
        Prosta p2 = Prosta.przesun(p1, v1);
        Assert.assertEquals(1, p2.a, 1e-9);
        Assert.assertEquals(-1, p2.b, 1e-9);
        Assert.assertEquals(-12, p2.c, 1e-9);
    }

    @Test
    public void testOdcinekPrzesuniecie() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Odcinek odcinek = new Odcinek(p1, p2);
        Wektor v = new Wektor(1, 1);
        odcinek.przesun(v);
        Assert.assertEquals(1, odcinek.start.getX(), 1e-9);
        Assert.assertEquals(1, odcinek.start.getY(), 1e-9);
        Assert.assertEquals(2, odcinek.end.getX(), 1e-9);
        Assert.assertEquals(2, odcinek.end.getY(), 1e-9);
    }

    @Test
    public void testOdcinekObrot() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Odcinek odcinek = new Odcinek(p1, p2);
        Punkt center = new Punkt(0, 0);
        odcinek.obroc(center, 180);
        Assert.assertEquals(0, odcinek.start.getX(), 1e-9);
        Assert.assertEquals(0, odcinek.start.getY(), 1e-9);
        Assert.assertEquals(-1, odcinek.end.getX(), 1e-9);
        Assert.assertEquals(-1, odcinek.end.getY(), 1e-9);
    }

    @Test
    public void testOdcinekOdbicie() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Odcinek odcinek = new Odcinek(p1, p2);
        Prosta prosta = new Prosta(1, 1, 0);
        odcinek.odbij(prosta);
        Assert.assertEquals(0, odcinek.start.getX(), 1e-9);
        Assert.assertEquals(0, odcinek.start.getY(), 1e-9);
        Assert.assertEquals(-1, odcinek.end.getX(), 1e-9);
        Assert.assertEquals(-1, odcinek.end.getY(), 1e-9);

        Odcinek odcinek2 = new Odcinek(p1, p2);
        Prosta prosta2 = new Prosta(1, -1, 0);
        odcinek2.odbij(prosta2);
        Assert.assertEquals(0, odcinek2.start.getX(), 1e-9);
        Assert.assertEquals(0, odcinek2.start.getY(), 1e-9);
        Assert.assertEquals(1, odcinek2.end.getX(), 1e-9);
        Assert.assertEquals(1, odcinek2.end.getY(), 1e-9);
    }

    @Test
    public void testTrojkatInit() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Punkt p3 = new Punkt(2, 0);
        Trojkat trojkat = new Trojkat(p1, p2, p3);
        Assert.assertNotNull(trojkat);

        Punkt p4 = new Punkt(2, 2);
        Assert.assertThrows(IllegalArgumentException.class, () -> {
            new Trojkat(p1, p2, p4);
        });
    }

    @Test
    public void testTrojkatPrzesun() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Punkt p3 = new Punkt(2, 0);
        Trojkat trojkat = new Trojkat(p1, p2, p3);
        Wektor v1 = new Wektor(1, -1);
        trojkat.przesun(v1);
        Assert.assertEquals(1, trojkat.p1.getX(), 1e-9);
        Assert.assertEquals(-1, trojkat.p1.getY(), 1e-9);
        Assert.assertEquals(2, trojkat.p2.getX(), 1e-9);
        Assert.assertEquals(0, trojkat.p2.getY(), 1e-9);
        Assert.assertEquals(3, trojkat.p3.getX(), 1e-9);
        Assert.assertEquals(-1, trojkat.p3.getY(), 1e-9);
    }

    @Test
    public void testTrojkatObrot() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Punkt p3 = new Punkt(2, 0);
        Trojkat trojkat = new Trojkat(p1, p2, p3);
        trojkat.obroc(p1, 180);
        Assert.assertEquals(0, trojkat.p1.getX(), 1e-9);
        Assert.assertEquals(0, trojkat.p1.getY(), 1e-9);
        Assert.assertEquals(-1, trojkat.p2.getX(), 1e-9);
        Assert.assertEquals(-1, trojkat.p2.getY(), 1e-9);
        Assert.assertEquals(-2, trojkat.p3.getX(), 1e-9);
        Assert.assertEquals(0, trojkat.p3.getY(), 1e-9);
    }

    @Test
    public void testTrojkatOdbij() {
        Punkt p1 = new Punkt(0, 0);
        Punkt p2 = new Punkt(1, 1);
        Punkt p3 = new Punkt(2, 0);
        Trojkat trojkat = new Trojkat(p1, p2, p3);
        Prosta prosta = new Prosta(1, 1, 0);
        trojkat.odbij(prosta);
        Assert.assertEquals(0, trojkat.p1.getX(), 1e-9);
        Assert.assertEquals(0, trojkat.p1.getY(), 1e-9);
        Assert.assertEquals(-1, trojkat.p2.getX(), 1e-9);
        Assert.assertEquals(-1, trojkat.p2.getY(), 1e-9);
        Assert.assertEquals(0, trojkat.p3.getX(), 1e-9);
        Assert.assertEquals(-2, trojkat.p3.getY(), 1e-9);
    }
}
