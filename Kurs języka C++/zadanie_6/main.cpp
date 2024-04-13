#include "wyrazenia.hpp"

int main()
{
    Wyrazenie *w = new Odejmij(
            new pi(),
            new Dodaj(
                    new Liczba(2), new Mnoz(
                            new Zmienna("x"), new Liczba(1)
                    )
            )
    );

    Wyrazenie *w1 = new Dziel(
            new Mnoz(
                    new Odejmij(
                            new Zmienna("x"), new Liczba(1)
                    ),
                    new Zmienna("x")
            ),
            new Liczba(2)
    );

    Wyrazenie *w2 = new Dziel(
            new Dodaj(
                    new Liczba(3), new Liczba(5)
            ),
            new Dodaj(
                    new Liczba(2), new Mnoz(
                            new Zmienna("x"), new Liczba(7)
                    )
            )
    );

    Wyrazenie *w3 = new Odejmij(
            new Dodaj(
                    new Liczba(2), new Mnoz(
                            new Zmienna("x"), new Liczba(7)
                    )
            ),
            new Dodaj(
                    new Mnoz(
                            new Zmienna("y"), new Liczba(3)
                    ),
                    new Liczba(5)
            )
    );

    Wyrazenie *w4 = new Dziel(
            new Cos(
                    new Mnoz(
                            new Dodaj(
                                    new Zmienna("x"),
                                    new Liczba(1)
                            ),
                            new pi()
                    )
            ),
            new Potega(
                    new e(),
                    new Potega(
                            new Zmienna("x"),
                            new Liczba(2)
                    )
            )
    );

    //test sposob 1
    /*
    Zmienna::dodajZmienna("x", 0);
    Zmienna::dodajZmienna("y", 0);

    for (double i = 0; i < 1.01; i += 0.01)
    {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
        cout << w->zapis() << " -> Wartosc: " << w->oblicz() << endl;
        cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
        cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
        cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
        cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
        cout << endl;
    }

    Zmienna::usunZmienna("y");
    Zmienna::dodajZmienna("y", 0.5);
    for (double i = 0; i < 1.01; i += 0.01)
    {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
        cout << w->zapis() << " -> Wartosc: " << w->oblicz() << endl;
        cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
        cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
        cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
        cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
        cout << endl;
    }

    Zmienna::usunZmienna("y");
    Zmienna::dodajZmienna("y", 1);
    for (double i = 0; i < 1.01; i += 0.01)
    {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
        cout << w->zapis() << " -> Wartosc: " << w->oblicz() << endl;
        cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
        cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
        cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
        cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
        cout << endl;
    }
*/
    //test sposob 2
/*
    Zmienna::dodajZmienna("x", 0);

    cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
    for (double i = 0; i < 1.01; i += 0.01) {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << " -> Wartosc: " << w1->oblicz() << endl;
    }
    cout << endl;

    Zmienna::modyfikujZmienna("x", -1);
    cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
    for (double i = 0; i < 1.01; i += 0.01) {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << " -> Wartosc: " << w2->oblicz() << endl;
    }
    cout << endl;

    Zmienna::modyfikujZmienna("x", -1);
    Zmienna::dodajZmienna("y", 0);

    cout << w3->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    for (double i = 0; i < 1.01; i += 0.01) {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << " -> Wartosc: " << w3->oblicz() << endl;
    }
    Zmienna::modyfikujZmienna("x", -1);
    Zmienna::modyfikujZmienna("y", 0.5);
    for (double i = 0; i < 1.01; i += 0.01) {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << " -> Wartosc: " << w3->oblicz() << endl;
    }
    cout << endl;

    Zmienna::modyfikujZmienna("x", -1);
    Zmienna::modyfikujZmienna("y", 0.5);
    for (double i = 0; i < 1.01; i += 0.01) {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << " -> Wartosc: " << w3->oblicz() << endl;
    }
    cout << endl;

    Zmienna::modyfikujZmienna("x", -1);
    cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    for (double i = 0; i < 1.01; i += 0.01) {
        Zmienna::modyfikujZmienna("x", i);
        cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << " -> Wartosc: " << w4->oblicz() << endl;
    }
*/

//test usuwania i dodawania
/*
        Wyrazenie *test = new Zmienna("x");
    cout << test->zapis() << " -> Wartosc: " << test->oblicz() << endl;
    Zmienna::usunZmienna("x");
    Zmienna::usunZmienna("x");
    Zmienna::dodajZmienna("x", 4);
    cout << test->zapis() << " -> Wartosc: " << test->oblicz() << endl;
    Zmienna::dodajZmienna("x", 6);
*/

    Zmienna::dodajZmienna("x", 0);
    Zmienna::dodajZmienna("y", 0);

    cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
    cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
    cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
    cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
    cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    cout << endl;

    Zmienna::modyfikujZmienna("y", 0.5);
    cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
    cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
    cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
    cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
    cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    cout << endl;

    Zmienna::modyfikujZmienna("x", 0.5);
    Zmienna::modyfikujZmienna("y", 0);
    cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
    cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
    cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
    cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
    cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    cout << endl;

    Zmienna::modyfikujZmienna("y", 0.5);
    cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
    cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
    cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
    cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
    cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    cout << endl;

    Zmienna::modyfikujZmienna("x", 1);
    Zmienna::modyfikujZmienna("y", 1);
    cout << "x = " << Zmienna("x").oblicz() << ", y = " << Zmienna("y").oblicz() << endl;
    cout << w1->zapis() << " -> Wartosc: " << w1->oblicz() << endl;
    cout << w2->zapis() << " -> Wartosc: " << w2->oblicz() << endl;
    cout << w3->zapis() << " -> Wartosc: " << w3->oblicz() << endl;
    cout << w4->zapis() << " -> Wartosc: " << w4->oblicz() << endl;
    cout << endl;

    return 0;
}