#include "trojkat.hpp"
#include "wszystko.hpp"

trojkat::trojkat() //konstruktor podstawowy (bezargumentowy)
{   a.setX(0);
    a.setY(0);
    b.setX(1);
    b.setY(0);
    c.setX(1);
    c.setY(1);
}

//konstrukor trojkata o wierzcholkach o podanych wspolrzednych
trojkat::trojkat(double x1, double y1, double x2, double y2, double x3, double y3)
{   if (x1 == x2 && x2 == x3 && y1 == y2 && y2 == y3)
        throw std::invalid_argument("Nie mozesz stworzyc trojkata o dlugosci boku 0.\n");

    double AB = (y1 - y2) / (x1 - x2);
    double BC = (y2 - y3) / (x2 - x3);

    if (AB == BC)
        throw std::invalid_argument("Punkty sa wspolliniowe.\n");

    else
    {   a.setX(x1);
        a.setY(y1);
        b.setX(x2);
        b.setY(y2);
        c.setX(x3);
        c.setY(y3);
    }
}

//kontruktor trojkata o trzech podanych wierzcholkach
trojkat::trojkat(punkt d, punkt e, punkt f)
{   if (d.getX() == e.getX() && e.getX() == f.getX() && d.getY() == e.getY() && e.getY() == f.getY())
        throw std::invalid_argument("Nie mozesz stworzyc trojkata o dlugosci boku 0.\n");

    double AB = (d.getY() - e.getY()) / (d.getX() - e.getX());
    double BC = (e.getY() - f.getY()) / (e.getX() - f.getX());

    if (AB == BC)
        throw std::invalid_argument("Punkty sa wspolliniowe.\n");

    else
    {   a = d;
        b = e;
        c = f;
    }
}

trojkat::trojkat(const trojkat& t) //kopia trojkata
{   a = t.a;
    b = t.b;
    c = t.c;
}

punkt trojkat::getA() //1 wierzcholek
{   return a;
}

punkt trojkat::getB() //2 wierzcholek
{   return b;
}

punkt trojkat::getC() //3 wierzcholek
{   return c;
}

void trojkat::przesun(double dx, double dy) //przesun trojkat o wektor (dx, dy)
{   a.setX( a.getX() + dx );
    a.setY( a.getY() + dy );
    b.setX( b.getX() + dx );
    b.setY( b.getY() + dy );
    c.setX( c.getX() + dx );
    c.setY( c.getY() + dy );
}

void trojkat::obroc(punkt d, double kat) //obroc trojkat wokol punktu d o kąt
{   a.setX((a.getX() - d.getX()) * cos(kat) - (a.getY() - d.getY()) * sin(kat) + d.getX());
    a.setY((a.getX() - d.getX()) * sin(kat) + (a.getY() - d.getY()) * cos(kat) + d.getY());

    b.setX((b.getX() - d.getX()) * cos(kat) - (b.getY() - d.getY()) * sin(kat) + d.getX());
    b.setY((b.getX() - d.getX()) * sin(kat) + (b.getY() - d.getY()) * cos(kat) + d.getY());

    c.setX((c.getX() - d.getX()) * cos(kat) - (c.getY() - d.getY()) * sin(kat) + d.getX());
    c.setY((c.getX() - d.getX()) * sin(kat) + (c.getY() - d.getY()) * cos(kat) + d.getY());
}

double trojkat::pole() //pole trojkata (ze wzoru prrr)
{   double x = obwod() / 2;
    double A = dlugosc(a, b);
    double B = dlugosc(b, c);
    double C = dlugosc(a, c);

    return sqrt(x * (x - A) * (x - B) * (x - C));
}

double trojkat::obwod() //obwod trojkata
{   return dlugosc(a, b) + dlugosc(b, c) + dlugosc(a, c);
}

bool trojkat::czyWsrodku(punkt d) //true - punkt jest zawarty w trojkacie, false - wpp
{   // punkt jest w trojkacie jesli zsumowanie pola "podtrojkatow"
    // ABD, ACD, BCD dają pole naszego trojkata ABC
    double A = pole();
    double A1 = trojkat(a,b,d).pole();
    double A2 = trojkat(a,c,d).pole();
    double A3 = trojkat(b,c,d).pole();

    //1e-9 - tolerancja, do dokladnosci
    if (std::abs(A - (A1 + A2 + A3)) < 1e-9)
        return true;
    else
        return false;
}

punkt trojkat::srodek() //punkt bedacy srodkiem trojkata
{   double x = (a.getX() + b.getX() + c.getX()) / 3;
    double y = (a.getY() + b.getY() + c.getY()) / 3;

    return punkt(x,y);
}

// funkcja zwraca referencje do strumienia wyjściowego out,
// dzięki czemu można wypisać informacje o obiekcie klasy odcinek za pomocą tego strumienia.
// W funkcji operatora wypisania, informacje o obiekcie klasy odcinek są wypisywane
// za pomocą operatora << na strumieniu out.
std::ostream& operator<<(std::ostream& out, const trojkat& t)
{   return out << "A = " << t.a << ", B = " << t.b << ", C = " << t.c;
}
