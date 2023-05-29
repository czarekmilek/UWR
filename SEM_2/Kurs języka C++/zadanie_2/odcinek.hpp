#ifndef odcinek_HPP
#define odcinek_HPP

#include <iostream>
#include <cmath>
#include <exception>
#include "punkt.hpp"

class odcinek //klasa odcinek, składa się z dwóch punktow a i b
{
private:
    punkt a;
    punkt b;

public:
    odcinek(); //konstruktor domyslny
    odcinek(double x1, double y1, double x2, double y2); //konstruktor z parametrami
    odcinek(punkt c, punkt d); //konstruktor z punktami
    odcinek(const odcinek& l); //konstruktor

    punkt getA(); //punkt a
    punkt getB(); //punkt b

    void przesun(double dx, double dy); //przesun odcinek o dx w OX i dy w OY
    void obroc(double bx, double by, double kat); //obroc odcinek o kąt wokół punktu (bx, by)

    double dlugosc(); //dlugosc odcinka
    bool nalezy(punkt c); //true - jesli c nalezy do odcinka, false - wpp
    punkt srodek(); //srodek odcinka

    friend std::ostream& operator<<(std::ostream& out, const odcinek& A);
};  //friend umożliwia dostęp do prywatnych zmiennych składowych klasy punkt,
    //aby umożliwić wyświetlenie obiektów klasy punkt na wyjsciu


#endif //odcinek_HPP
