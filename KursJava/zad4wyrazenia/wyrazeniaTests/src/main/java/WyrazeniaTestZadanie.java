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

public class WyrazeniaTestZadanie {

    @BeforeEach
    public void setUp() {
        Zmienna.zbiorZmiennych.czysc();
        Zmienna.zbiorZmiennych.wstaw(new Para("x", 1.618));
    }

    // Test wyrażenia 7.2 + x * 2.4
    @Test
    public void testWyrazenie0() {
        Wyrazenie wyrazenie = new Dodaj(
                new Liczba(7.2),
                new Mnoz(
                        new Zmienna("x"),
                        new Liczba(2.4)
                )
        );
        assertEquals(11.0832, wyrazenie.oblicz(), 1e-4);
        assertEquals("(7.2 + (x * 2.4))", wyrazenie.toString());
    }

    // Test wyrażenia: ~ (2 - x) * e
    @Test
    public void testWyrazenie2() {
        Wyrazenie wyrazenie = new Mnoz(
                new Negacja(
                        new Odejmij(
                                new Liczba(2),
                                new Zmienna("x")
                        )
                ),
                Stala.E
        );
        assertEquals(-1.03838, wyrazenie.oblicz(), 1e-5);
        assertEquals("(~(2.0 - x) * e)", wyrazenie.toString());
    }

    // Test wyrażenia: (3 * π - 1) / (! x + 5)
    @Test
    public void testWyrazenie3() {
        Wyrazenie wyrazenie = new Dziel(
                new Odejmij(
                        new Mnoz(
                                new Liczba(3),
                                Stala.PI),
                        new Liczba(1)
                ),
                new Odwrotnosc(
                        new Dodaj(
                                new Zmienna("x"),
                                new Liczba(5)
                        )
                )
        );
        assertEquals(55.75518, wyrazenie.oblicz(), 1e-3);
        assertEquals("(((3.0 * π) - 1.0) / (! (x + 5.0)))", wyrazenie.toString());
    }

    // Test wyrażenia: sin((x + 13) * π / (1 - x))
    @Test
    public void testWyrazenie4() {
        Wyrazenie wyrazenie = new Sin(
                new Dziel(
                        new Mnoz(
                                new Dodaj(
                                        new Zmienna("x"),
                                        new Liczba(13)
                                ),
                                Stala.PI),
                        new Odejmij(
                                new Liczba(1),
                                new Zmienna("x")
                        )
                )
        );
        assertEquals(0.885638, wyrazenie.oblicz(), 1e-4);
        assertEquals("sin((((x + 13.0) * π) / (1.0 - x)))", wyrazenie.toString());
    }

    // Test wyrażenia: exp(5) + x * log(e, x)
    @Test
    public void testWyrazenie5() {
        Wyrazenie wyrazenie = new Dodaj(
                new Exp(
                        new Liczba(5)
                ),
                new Mnoz(
                        new Zmienna("x"),
                        new Log(Stala.E,
                                new Zmienna("x")
                        )
                )
        );
        assertEquals(149.19173, wyrazenie.oblicz(), 1e-2);
        assertEquals("(exp(5.0) + (x * log(e, x)))", wyrazenie.toString());
    }
}
