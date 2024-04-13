#include "wszystko.hpp"

double dlugosc(punkt a, punkt b) //zwraca odległość między dwoma punktami a i b
{   double x = b.getX() - a.getX();
    double y = b.getY() - a.getY();

    return sqrt(pow(x, 2) + pow(y, 2));
}

bool czyRownolegle(odcinek c, odcinek d) //true - c i d rownolegle, false - wpp
{   // y = sx + t
    double s1 = (c.getA().getY() - c.getB().getY()) / (c.getA().getX() - c.getB().getX());
    double s2 = (d.getA().getY() - d.getB().getY()) / (d.getA().getX() - d.getB().getX());

    if (s1 == s2)
        return true;
    else
        return false;
}

bool czyProstopadle(odcinek c, odcinek d) //true - c i d prostopadle, false - wpp
{   double s1 = (c.getA().getY() - c.getB().getY()) / (c.getA().getX() - c.getB().getX());
    double s2 = (d.getA().getY() - d.getB().getY()) / (d.getA().getX() - d.getB().getX());

    if (s1 == (-1 / s2))
        return true;
    else
        return false;
}

// orientacja trójki punktów a, b i c
// funkcja jest potrzebna do sprawdzenia, czy dwa odcinki przecinają się
int orientacja(punkt a, punkt b, punkt c) //
{   int value = (b.getY() - a.getY()) * (c.getX() - b.getX()) - (b.getX() - a.getX()) * (c.getY() - b.getY());

    if (value == 0)
        return 0; // czyli jest wspolliniowe
    else if (value > 0)
        return 1; // counter-clockwise
    else
        return 2; // clockwise
}

bool czyPrzecina(odcinek c, odcinek d) //true - c i d przecinaja sie, false - wpp
{   punkt p1 = c.getA();
    punkt q1 = c.getB();
    punkt p2 = d.getA();
    punkt q2 = d.getB();

    int o1 = orientacja(p1, q1, p2);
    int o2 = orientacja(p1, q1, q2);
    int o3 = orientacja(p2, q2, p1);
    int o4 = orientacja(p2, q2, q1);

    if (o1 != o2 && o3 != o4)
        return true;

    // p1, q1, p2 sa wspolliniowe, p2 lezy na c
    if (o1 == 0 && c.nalezy(p2))
        return true;
    // p1, q1, q2 sa wspolliniowe, q2 lezy na c
    if (o2 == 0 && c.nalezy(q2))
        return true;
    // p2, q2, p1 sa wspolliniowe, p1 lezy na d
    if (o3 == 0 && d.nalezy(p1))
        return true;
    // p2, q2, q1 sa wspolliniowe, q1 lezy na d
    if (o4 == 0 && d.nalezy(q1))
        return true;

    return false;
}

bool czyTrojkatyZawierajaSie(trojkat u, trojkat v) //true - zawieraja, false - wpp
{   punkt a1 = u.getA();
    punkt b1 = u.getB();
    punkt c1 = u.getC();
    punkt a2 = v.getA();
    punkt b2 = v.getB();
    punkt c2 = v.getB();

    if (u.czyWsrodku(a2) && u.czyWsrodku(b2) && u.czyWsrodku(c2))
        return true;
    else if (v.czyWsrodku(a1) && v.czyWsrodku(b1) && v.czyWsrodku(c1))
        return true;
    else
        return false;
}

bool czyTrojkatyPrzecinajaSie(trojkat u, trojkat v) //true - przecinaja, false - wpp
{   if (czyTrojkatyZawierajaSie(u, v))
        return false;

    punkt a1 = u.getA();
    punkt b1 = u.getB();
    punkt c1 = u.getC();
    punkt a2 = v.getA();
    punkt b2 = v.getB();
    punkt c2 = v.getB();

    odcinek ls1(a1, b1);
    odcinek ls2(b1, c1);
    odcinek ls3(a1, c1);
    odcinek ls4(a2, b2);
    odcinek ls5(b2, c2);
    odcinek ls6(a2, c2);

    if (czyPrzecina(ls1, ls4) || czyPrzecina(ls1, ls5) || czyPrzecina(ls1, ls6))
        return true;
    if (czyPrzecina(ls2, ls4) || czyPrzecina(ls2, ls5) || czyPrzecina(ls2, ls6))
        return true;
    if (czyPrzecina(ls3, ls4) || czyPrzecina(ls3, ls5) || czyPrzecina(ls3, ls6))
        return true;

    return false;

}
