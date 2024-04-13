#ifndef trojkat_HPP
#define trojkat_HPP

#include <iostream>
#include <cmath>
#include <exception>
#include "punkt.hpp"

class trojkat //klasa trójkąt, składa się z trzech punktów a, b i c
{
private: //wierzchołki trójkąta
    punkt a;
    punkt b;
    punkt c;

public:
    trojkat(); //konstruktor podstawowy
    trojkat(double x1, double y1, double x2, double y2, double x3, double y3); //konstruktor z parametrami współrzędnych
    trojkat(punkt d, punkt e, punkt f); //konstruktor z punktami
    trojkat(const trojkat& t); //konstruktor z referencją

    punkt getA(); //1 wierzchołek
    punkt getB(); //2 wierzchołek
    punkt getC(); //3 wierzchołek

    void przesun(double dx, double dy);  //przesun wszystkie wspolrzedne trojkata o (dx, dy)
    void obroc(punkt d, double kat); //obroc trojkat wokól punktu d o kąt

    double pole(); //pole trojkata
    double obwod(); //obwod trojkata
    bool czyWsrodku(punkt d); //true - punkt znajduje sie w trojkacie, false - wpp
    punkt srodek(); // punkt bedacy srodkiem trojkata

    friend std::ostream& operator<<(std::ostream& out, const trojkat& t);
};  //friend umożliwia dostęp do prywatnych zmiennych składowych klasy punkt,
    //aby umożliwić wyświetlenie obiektów klasy punkt na wyjsciu


#endif //trojkat_HPP
