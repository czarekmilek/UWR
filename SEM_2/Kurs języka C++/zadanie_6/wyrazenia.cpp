#include "wyrazenia.hpp"

vector<pair<string, double>> Zmienna::variables;

Liczba::Liczba(double value)
{
    this->value = value;
}

string Liczba::zapis()
{
    stringstream stream;
    if (value == (int)value)
    {
        stream << fixed << setprecision(0) << value;
    }
    else
    {
        stream << fixed << setprecision(ceil(value)) << value;
    }
    return stream.str();
}

double Liczba::oblicz()
{
    return value;
}

Zmienna::Zmienna(string name)
{
    this->name = name;
}

string Zmienna::zapis()
{
    return name;
}

double Zmienna::oblicz()
{
    try
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (variables[i].first == name)
            {
                return variables[i].second;
            }
        }
        return 0;
        string err = "oblicz: Zmienna nie istnieje.";
        throw err;
    }
    catch(string err)
    {
        cerr << err << '\n';
    }
}

void Zmienna::dodajZmienna(string name, double val)
{
    try
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (variables[i].first == name)
            {
                throw invalid_argument("dodajZmienna: Zmienna juz istnieje");
            }
        }
        variables.push_back(pair<string, double> (name, val));
    }
    catch(const exception& e)
    {
        cerr << e.what() << '\n';
    }
}

void Zmienna::usunZmienna(string name)
{
    try
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (Zmienna::variables[i].first == name)
            {
                Zmienna::variables.erase(Zmienna::variables.begin() + i);
            }
        }
        string err = "usunZmienna: Zmienna nie istnieje.";
    }
    catch(string err)
    {
        cerr << err << '\n';
    }
}

void Zmienna::modyfikujZmienna(string name, double val)
{
    try
    {
        for (int i = 0; i < variables.size(); i++)
        {
            if (variables[i].first == name)
            {
                variables[i].second = val;
            }
        }
        string err = "modyfikujZmienna: Zmienna nie istnieje.";
    }
    catch(string err)
    {
        cerr << err << '\n';
    }
}

pi::pi()
{
    value = 3.1415926535897;
}

string pi::zapis()
{
    return "pi";
}

double pi::oblicz()
{
    return value;
}

e::e()
{
    value = 2.7182818284590;
}

string e::zapis()
{
    return "e";
}

double e::oblicz()
{
    return value;
}

fi::fi()
{
    value = 1.618033988749;
}

string fi::zapis()
{
    return "fi";
}

double fi::oblicz()
{
    return value;
}

Operator1Arg::Operator1Arg(Wyrazenie *a1)
{
    this->a1 = a1;
}

string Sin::zapis()
{
    return "sin(" + a1->zapis() + ")";
}

double Sin::oblicz()
{
    return sin(a1->oblicz());
}

string Ln::zapis()
{
    return "ln(" + a1->zapis() + ")";
}

double Ln::oblicz()
{
    return log(a1->oblicz());
}

string Exp::zapis()
{
    return "exp(" + a1->zapis() + ")";
}

double Exp::oblicz()
{
    return exp(a1->oblicz());
}

string Cos::zapis()
{
    return "cos(" + a1->zapis() + ")";
}

double Cos::oblicz()
{
    return cos(a1->oblicz());
}

string Bezwzgl::zapis()
{
    return "|" + a1->zapis() + "|";
}

double Bezwzgl::oblicz()
{
    return abs(a1->oblicz());
}

string Przeciw::zapis()
{
    return "-(" + a1->zapis() + ")";
}

double Przeciw::oblicz()
{
    return a1->oblicz() * (-1);
}

string Odwrot::zapis()
{
    return "1/(" + a1->zapis() + ")";
}

double Odwrot::oblicz()
{
    return 1 / a1->oblicz();
}

Operator2arg::Operator2arg(Wyrazenie *a1, Wyrazenie *a2) : Operator1Arg(a1)
{
    this->a2 = a2;
}

string Dodaj::zapis()
{
    string left = a1->zapis();
    string right = a2->zapis();
    if (a1->priorytet() < Dodaj::priorytet())
    {
        left = "(" + left + ")";
    }
    if (a2->priorytet() <= Dodaj::priorytet())
    {
        right = "(" + right + ")";
    }
    return left + " + " + right;
}


double Dodaj::oblicz()
{
    return a1->oblicz() + a2->oblicz();
}

string Odejmij::zapis()
{
    string left = a1->zapis();
    string right = a2->zapis();
    if (a1->priorytet() < Odejmij::priorytet())
    {
        left = "(" + left + ")";
    }
    if (a2->priorytet() <= Odejmij::priorytet())
    {
        right = "(" + right + ")";
    }
    return left + " - " + right;
}

double Odejmij::oblicz()
{
    return a1->oblicz() - a2->oblicz();
}

string Mnoz::zapis()
{
    string left = a1->zapis();
    string right = a2->zapis();
    if (a1->priorytet() < Mnoz::priorytet())
    {
        left = "(" + left + ")";
    }
    if (a2->priorytet() <= Mnoz::priorytet())
    {
        right = "(" + right + ")";
    }
    return left + " * " + right;
}

double Mnoz::oblicz()
{
    return a1->oblicz() * a2->oblicz();
}

string Dziel::zapis()
{
    string left = a1->zapis();
    string right = a2->zapis();
    if (a1->priorytet() < Dziel::priorytet())
    {
        left = "(" + left + ")";
    }
    if (a2->priorytet() <= Dziel::priorytet())
    {
        right = "(" + right + ")";
    }
    return left + " / " + right;
}

double Dziel::oblicz()
{
    return a1->oblicz() / a2->oblicz();
}

string Modulo::zapis()
{
    string left = a1->zapis();
    string right = a2->zapis();
    if (a1->priorytet() < Modulo::priorytet())
    {
        left = "(" + left + ")";
    }
    if (a2->priorytet() <= Modulo::priorytet())
    {
        right = "(" + right + ")";
    }
    return left + " % " + right;
}

double Modulo::oblicz()
{
    return fmod(a1->oblicz(), a2->oblicz());
}

string Potega::zapis()
{
    string left = a1->zapis();
    string right = a2->zapis();
    if (a1->priorytet() <= Potega::priorytet())
    {
        left = "(" + left + ")";
    }
    if (a2->priorytet() < Potega::priorytet())
    {
        right = "(" + right + ")";
    }
    return left + " ^ " + right;
}

double Potega::oblicz()
{
    return pow(a1->oblicz(), a2->oblicz());
}

string Logarytm::zapis()
{
    return "log_" + a1->zapis() + "(" + a2->zapis() + ")";
}

double Logarytm::oblicz()
{
    return log(a2->oblicz() / log(a1->oblicz()));
}