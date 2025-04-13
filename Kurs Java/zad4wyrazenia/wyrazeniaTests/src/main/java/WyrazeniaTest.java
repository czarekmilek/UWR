import obliczenia.*;
import obliczenia.dzialanie.fun1.*;
import obliczenia.dzialanie.fun2.*;
import obliczenia.operand.*;
import obliczenia.dzialanie.oper1.*;
import obliczenia.dzialanie.oper2.*;
import struktury.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class WyrazeniaTest {

    @BeforeEach
    public void setUp() {
        Zmienna.zbiorZmiennych.czysc();
        Zmienna.zbiorZmiennych.wstaw(new Para("x", 2.0));
        Zmienna.zbiorZmiennych.wstaw(new Para("y", 5.0));
    }

    @Test
    public void testLiczba() {
        Wyrazenie liczba = new Liczba(5.0);
        assertEquals(5.0, liczba.oblicz(), 1e-9);
        assertEquals("5.0", liczba.toString());
    }

    @Test
    public void testStale() {
        assertEquals(Math.PI, Stala.PI.oblicz(), 1e-9);
        assertEquals(Math.E, Stala.E.oblicz(), 1e-9);
        assertEquals("π", Stala.PI.toString());
        assertEquals("e", Stala.E.toString());
    }

    @Test
    public void testDodawanie() {
        Wyrazenie dodaj = new Dodaj(new Liczba(3.0), new Liczba(4.0));
        assertEquals(7.0, dodaj.oblicz(), 1e-9);
    }

    @Test
    public void testOdejmowanie() {
        Wyrazenie odejmij = new Odejmij(new Liczba(10.0), new Liczba(4.0));
        assertEquals(6.0, odejmij.oblicz(), 1e-9);
    }

    @Test
    public void testMnozenie() {
        Wyrazenie mnoz = new Mnoz(new Liczba(2.0), new Liczba(5.0));
        assertEquals(10.0, mnoz.oblicz(), 1e-9);
    }

    @Test
    public void testDzielenie() {
        Wyrazenie dziel = new Dziel(new Liczba(10.0), new Liczba(2.0));
        assertEquals(5.0, dziel.oblicz(), 1e-9);
    }

    @Test
    public void testDzieleniePrzezZero() {
        assertThrows(ArithmeticException.class, () -> new Dziel(new Liczba(1.0), new Liczba(0.0)).oblicz());
    }

    @Test
    public void testNegacja() {
        Wyrazenie negacja = new Negacja(new Liczba(5.0));
        assertEquals(-5.0, negacja.oblicz(), 1e-9);
    }

    @Test
    public void testOdwrotnosc() {
        Wyrazenie odwrotnosc = new Odwrotnosc(new Liczba(4.0));
        assertEquals(0.25, odwrotnosc.oblicz(), 1e-9);
    }

    @Test
    public void testLn() {
        Wyrazenie ln = new Ln(new Liczba(Math.E));
        assertEquals(1.0, ln.oblicz(), 1e-9);
    }

    @Test
    public void testExp() {
        Wyrazenie exp = new Exp(new Liczba(1.0));
        assertEquals(Math.E, exp.oblicz(), 1e-9);
    }

    @Test
    public void testSin() {
        Wyrazenie sin = new Sin(new Liczba(Math.PI / 2));
        assertEquals(1.0, sin.oblicz(), 1e-9);
    }

    @Test
    public void testCos() {
        Wyrazenie cos = new Cos(new Liczba(Math.PI));
        assertEquals(-1.0, cos.oblicz(), 1e-9);
    }

    @Test
    public void testLog() {
        Wyrazenie log = new Log(new Liczba(10.0), new Liczba(100.0));
        assertEquals(2.0, log.oblicz(), 1e-9);
    }

    @Test
    public void testPot() {
        Wyrazenie pot = new Pot(new Liczba(2.0), new Liczba(3.0));
        assertEquals(8.0, pot.oblicz(), 1e-9);
    }

    @Test
    public void testZmienna() {
        Wyrazenie zmiennaX = new Zmienna("x");
        Wyrazenie zmiennaY = new Zmienna("y");
        assertEquals(2.0, zmiennaX.oblicz(), 1e-9);
        assertEquals(5.0, zmiennaY.oblicz(), 1e-9);
    }

    @Test
    public void testAktualizacjaZmiennych() {
        Zmienna.zbiorZmiennych.wstaw(new Para("x", 10.0));
        Wyrazenie zmiennaX = new Zmienna("x");
        assertEquals(10.0, zmiennaX.oblicz(), 1e-9);
    }

    @Test
    public void testBrakZmienna() {
        Wyrazenie nieistniejacaZmienna = new Zmienna("z");
        assertThrows(IllegalStateException.class, nieistniejacaZmienna::oblicz);
    }

    @Test
    public void testSumaWyrazen() {
        double suma = Wyrazenie.suma(new Liczba(2.0), new Liczba(3.0), new Liczba(5.0));
        assertEquals(10.0, suma, 1e-9);
    }

    @Test
    public void testIloczynWyrazen() {
        double iloczyn = Wyrazenie.iloczyn(new Liczba(2.0), new Liczba(3.0), new Liczba(5.0));
        assertEquals(30.0, iloczyn, 1e-9);
    }

    @Test
    public void testKlonowanieZbioru() {
        ZbiorTablicowy zbior1 = new ZbiorTablicowy(5);
        zbior1.wstaw(new Para("a", 10.0));
        zbior1.wstaw(new Para("b", 20.0));

        ZbiorTablicowy zbior2 = zbior1.clone();
        assertNotSame(zbior1, zbior2);
        assertEquals(zbior1.ile(), zbior2.ile());
        assertEquals(zbior1.szukaj("a").getWartosc(), zbior2.szukaj("a").getWartosc(), 1e-9);
    }

    @Test
    public void testWyrazenieZlozone() {
        Wyrazenie wyrazenie = new Dodaj(
                new Odejmij(
                        new Liczba(7),
                        new Mnoz(
                                new Liczba(5),
                                new Liczba(3))),
                new Dziel(
                        new Zmienna("x"),
                        new Liczba(2))
        );
        assertEquals(-7.0, wyrazenie.oblicz(), 1e-9);
    }
}
