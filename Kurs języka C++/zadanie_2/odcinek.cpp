#include "odcinek.hpp"

odcinek::odcinek() //nowy obiekt klasy odcinek
{   a.setX(0);
    a.setY(0);
    b.setX(1);
    b.setY(1);
}

//konstruktor przyjmuje cztery argumenty typu double
//reprezentujące współrzędne końców odcinka,
//jeśli odcinek ma długość 0, funkcja rzuca wyjątek
odcinek::odcinek(double x1, double y1, double x2, double y2)
{
    if (x1 == x2 && y1 == y2)
        throw std::invalid_argument("Nie mozesz stworzyc odcinka o dlugosci 0.\n");
    else
    {   a.setX(x1);
        a.setY(y1);
        b.setX(x2);
        b.setY(y2);
    }
}
// konstruktor przyjmuje dwa argumenty typu punkt
// reprezentujące końce odcinka,
// jeśli odcinek ma długość 0, funkcja rzuca wyjątek
odcinek::odcinek(punkt c, punkt d)
{   if (c.getX() == d.getX() && c.getY() == d.getY())
        throw std::invalid_argument("Nie mozesz stworzyc odcinka o dlugosci 0.\n");
    else
    {   a = c;
        b = d;
    }
}

// nowy obiekt klasy odcinek na podstawie innego obiektu klasy odcinek (kopia)
odcinek::odcinek(const odcinek& l)
{   a = l.a;
    b = l.b;
}

//pierwszy koniec odcinka
punkt odcinek::getA()
{   return a;
}

//drugi koniec odcinka
punkt odcinek::getB()
{   return b;
}

//funkcja przesuwa oba końce odcinka o wartości dx i dy
void odcinek::przesun(double dx, double dy)
{   a.setX( a.getX() + dx );
    a.setY( a.getY() + dy );
    b.setX( b.getX() + dx );
    b.setY( b.getY() + dy );
}

//funkcja obraca odcinek o zadany kąt wokół punktu o współrzędnych (bx,by)
void odcinek::obroc(double bx, double by, double kat)
{   a.setX((a.getX() - bx) * cos(kat) - (a.getY() - by) * sin(kat) + bx);
    a.setY((a.getX() - bx) * sin(kat) + (a.getY() - by) * cos(kat) + by);

    b.setX((b.getX() - bx) * cos(kat) - (b.getY() - by) * sin(kat) + bx);
    b.setY((b.getX() - bx) * sin(kat) + (b.getY() - by) * cos(kat) + by);
}

//dlugosc odcinka
double odcinek::dlugosc()
{   double x = b.getX() - a.getX();
    double y = b.getY() - a.getY();

    return sqrt(pow(x, 2) + pow(y, 2));
}

//true - punkt nalezy do odcinka, false - wpp
bool odcinek::nalezy(punkt c)
{   if ((c.getX() <= b.getX() && c.getY() <= b.getY() && c.getX() >= a.getX() && c.getY() >= a.getY())
        || (c.getX() >= b.getX() && c.getY() >= b.getY() && c.getX() <= a.getX() && c.getY() <= a.getY()))
    {
        // y = sx + t (ax + b)
        double s = (a.getY() - b.getY()) / (a.getX() - b.getX()); //nachylenie prostej (a)
        double t = a.getY() - (a.getY() - b.getY()) / (a.getX() - b.getX()) * a.getX(); //przecięcie prostej z OY (b)

        // 1e-10 to tolerancja - pomaga w dokladnosci

        // wartość y dla punktu c jest porównywana z
        // wartością y obliczoną na podstawie równania prostej
        if (std::abs(c.getY() - (s * c.getX() + t)) <= 1e-10)
            return true;
        else
            return false;
    }
    else
        return false;
}

//punkt bedacy srodkiem odcinka
punkt odcinek::srodek()
{   punkt c;
    c.setX((a.getX()+b.getX()) / 2);
    c.setY((a.getY()+b.getY()) / 2);

    return c;
}



// funkcja zwraca referencje do strumienia wyjściowego out,
// dzięki czemu można wypisać informacje o obiekcie klasy odcinek za pomocą tego strumienia.
// W funkcji operatora wypisania, informacje o obiekcie klasy odcinek są wypisywane
// za pomocą operatora << na strumieniu out.
std::ostream& operator<<(std::ostream& out, const odcinek& A) //wypisanie odcinka
{   return out << "A = " << A.a << ", B = " << A.b;
}
