#ifndef punkt_HPP
#define punkt_HPP

#include <iostream>
#include <cmath>


class prosta //klasa prosta, składa się z dwóch zmiennych składowych typu double x i y
{
private:
    double a;
    double b;
public:
    prosta(double x1, double y1, double x2, double y2);
    double getA(); //pobierz wartosc a
    double getB(); //pobierz wartosc b
};


class punkt //klasa punkt, składa się z dwóch zmiennych składowych typu double x i y
{
private:
    double x;
    double y;

public:
    punkt(); //konstruktor domyślny
    punkt(double val_x, double val_y); //konstruktor z parametrami
    punkt(const punkt& p); //konstruktor kopiujący punkt

    void przesun(double dx, double dy); //przesuwanie
    void obroc(double bx, double by, double kat); //obracanie

    void setX(double val); //ustaw wartosc x
    void setY(double val); //ustaw wartosc y
    double getX(); //pobierz wartosc x
    double getY(); //pobierz wartosc y

    void osSymetrii(prosta &p);
    void symetria_srodkowa(punkt &p);

    friend std::ostream& operator<<(std::ostream& out, const punkt& A);
};  //friend umożliwia dostęp do prywatnych zmiennych składowych klasy punkt,
    //aby umożliwić wyświetlenie obiektów klasy punkt na wyjsciu



#endif //punkt_HPP
