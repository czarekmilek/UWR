
#include <iostream>
#include <vector>
#include <cmath>
#include <stdexcept>
#include <iomanip>

using namespace std;

class Wyrazenie
{
public:
    virtual string zapis() = 0; //zapis wyrażenia w postaci napisu
    virtual double oblicz() = 0; //wynik obliczenia wartości wyrażenia
    virtual int priorytet() {return 4;} //priorytet wyrażenia określający kolejność wykonywania działań
    virtual ~Wyrazenie(){};
};

class Liczba : public virtual Wyrazenie
{
public:
    double value;
    Liczba(double value);
    string zapis(); //zapis wyrażenia w postaci napisu
    double oblicz(); //wynik obliczenia wartości wyrażenia
};

class Zmienna : public virtual Wyrazenie
{
private:
    static vector<pair<string, double>> variables;

public:
    string name;
    Zmienna(string name);
    string zapis(); //zapis wyrażenia w postaci napisu
    double oblicz(); //wynik obliczenia wartości wyrażenia
    static void dodajZmienna(string name, double val); //dodanie nowej zmiennej
    static void usunZmienna(string name); //usuniecie starej zmiennej
    static void modyfikujZmienna(string name, double val); //modyfikacja obecnej zmiennej
};


class Stala : public virtual Wyrazenie
{
protected:
    double value;
};


class pi : public Stala
{
public:
    pi();
    string zapis();
    double oblicz();
};

class e : public Stala
{
public:
    e();
    string zapis();
    double oblicz();
};

class fi : public Stala
{
public:
    fi();
    string zapis();
    double oblicz();
};


class Operator1Arg : public virtual Wyrazenie
{
public:
    Wyrazenie *a1;
    Operator1Arg(Wyrazenie *a1);
};

class Sin : public Operator1Arg
{
public:
    Sin(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Ln : public Operator1Arg
{
public:
    Ln(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Exp : public Operator1Arg
{
public:
    Exp(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Cos : public Operator1Arg
{
public:
    Cos(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Bezwzgl : public Operator1Arg
{
public:
    Bezwzgl(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Przeciw : public Operator1Arg
{
public:
    Przeciw(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Odwrot : public Operator1Arg
{
public:
    Odwrot(Wyrazenie *a1) : Operator1Arg(a1) {}
    string zapis();
    double oblicz();
};

class Operator2arg : public Operator1Arg
{
public:
    Wyrazenie *a2;
    Operator2arg(Wyrazenie *a1, Wyrazenie *a2);
};

class Dodaj : public Operator2arg
{
public:
    Dodaj(Wyrazenie *a1, Wyrazenie *a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 1;}
};

class Odejmij : public Operator2arg
{
public:
    Odejmij(Wyrazenie *a1, Wyrazenie *a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 1;}
};

class Mnoz : public Operator2arg
{
public:
    Mnoz(Wyrazenie *a1, Wyrazenie*a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 2;}
};

class Dziel : public Operator2arg
{
public:
    Dziel(Wyrazenie *a1, Wyrazenie*a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 2;}
};

class Modulo : public Operator2arg
{
public:
    Modulo(Wyrazenie *a1, Wyrazenie*a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 2;}
};


class Potega : public Operator2arg
{
public:
    Potega(Wyrazenie *a1, Wyrazenie*a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 3;}
};

class Logarytm : public Operator2arg
{
public:
    Logarytm(Wyrazenie *a1, Wyrazenie *a2) : Operator2arg(a1, a2) {}
    string zapis();
    double oblicz();
    int priorytet() override {return 3;}
};


