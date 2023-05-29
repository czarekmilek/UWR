#include "punkt.hpp"

punkt::punkt() //Ustaw wartości x i y na 0 dla nowo utworzonego obiektu klasy punkt
{   x = 0;
    y = 0;
}

punkt::punkt(double val_x, double val_y) //Ustaw wartości x i y obiektu klasy punkt wartościami val_x i val_y
{   x = val_x;
    y = val_y;
}

punkt::punkt(const punkt& p) //Ustaw wartości x i y obiektu klasy punkt wartościami x i y obiektu p
{   x = p.x;
    y = p.y;
}

void punkt::przesun(double dx, double dy) //Przesuwa punkt o wartość dx w OX i wartość dy w OY.
{   x = x + dx;
    y = y + dy;
}

void punkt::obroc(double bx, double by, double kat) //Obraca punkt wokół punktu (bx, by) o kąt podany w radianach
{   x = (x - bx) * cos(kat) - (y - by) * sin(kat) + bx;
    y = (x - bx) * sin(kat) + (y - by) * cos(kat) + by;
}

void punkt::symetria_srodkowa(punkt &p)
{   p.obroc(0, 0, M_PI); // obrót o π radianów względem punktu (0,0)
}

void punkt::setX(double val) //Ustaw wartość x obiektu klasy punkt na wartość val
{   x = val;
}

void punkt::setY(double val) //Ustaw wartość y obiektu klasy punkt na wartość val
{   y = val;
}

double punkt::getX() //Zwraca wartość x obiektu klasy punkt
{   return x;
}

double punkt::getY() //Zwraca wartość y obiektu klasy punkt
{   return y;
}


std::ostream& operator<<(std::ostream& out, const punkt& A) //wypisuje na wyjsciu wartości x i y punktu
{
    return out << "(" << A.x << ", " << A.y << ")";
}


prosta::prosta(double x1, double y1, double x2, double y2)
{   a = (y1 - y2) / (x1 - x2);
    b = y1 - a * x1;
}

double prosta::getA() //Zwraca wartość y obiektu klasy punkt
{   return a;
}

double prosta::getB() //Zwraca wartość y obiektu klasy punkt
{   return b;
}

void punkt::osSymetrii(prosta &p){
    double w = (1 - p.getA() * p.getA()) / (1 + p.getA() * p.getA()) * p.getA() +
               (2 * p.getA()) / (1 + p.getA() * p.getA()) * getY() -
               (2 * p.getA() * p.getB()) / (1 + p.getA() * p.getA());

    double z = (2 * p.getA()) / (1 + p.getA() * p.getA()) * p.getA() +
               (p.getA() * p.getA() - 1) / (p.getA() * p.getA() + 1) * getY() +
               (2 * p.getB()) / (p.getA() * p.getA() + 1);
    this->x = w;
    this->y = z;
}