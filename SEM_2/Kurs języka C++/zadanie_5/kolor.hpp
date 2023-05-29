#pragma once
#include <iostream>
#include <stdexcept>

using namespace std;

class kolor {
protected:
    unsigned char red;
    unsigned char green;
    unsigned char blue;

public:
    kolor();
    kolor(int r, int g, int b);

    int getRed() const;
    int getGreen() const;
    int getBlue() const
    ;
    void setRed(int r);
    void setGreen(int g);
    void setBlue(int b);

    // Metody do zmiany jasności koloru
    void rozjasnij(int value);
    void przyciemnij(int value);

    // Metoda statyczna do łączenia kolorów
    static kolor lacz(kolor k1, kolor k2);

    friend std::ostream& operator<<(std::ostream& out, const kolor& k);
};

// Reprezentuje kolor z wartością alpha, która określa przezroczystość koloru
class kolor_transparentny : public virtual kolor {
public:
    kolor_transparentny();
    kolor_transparentny(int r, int g, int b, int a);
    kolor_transparentny(const kolor& kolor, int a);

    int getAlpha() const;
    void setAlpha(int a);

    friend std::ostream& operator<<(std::ostream& out, const kolor_transparentny& k);
protected:
    int alpha;
};

// Reprezentuje kolor z nazwą, która opisuje kolor w sposób tekstowy
class kolor_nazwany : public virtual kolor {
public:
    kolor_nazwany();
    kolor_nazwany(int r, int g, int b, const string& name);

    string getName() const;
    void setName(const string& name);

    friend std::ostream& operator<<(std::ostream& out, const kolor_nazwany& k);
protected:
    string name;
};

// Reprezentuje kolor z wartością alpha i nazwą
class kolor_nt : public kolor_transparentny, public kolor_nazwany {
public:
    kolor_nt();
    kolor_nt(int r, int g, int b, int a, const string& name);

    void setAlpha(int a);
    void setName(const string& name);
    void setRed(int r);
    void setGreen(int g);
    void setBlue(int b);

    friend std::ostream& operator<<(std::ostream& out, const kolor_nt& k);
};
