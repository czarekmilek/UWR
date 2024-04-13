#pragma once
#include <cmath>
#include "kolor.hpp"

class pixel {
public:
    pixel(int x = 0, int y = 0);

    int getX() const;
    int getY() const;

    void setX(int x);
    void setY(int y);

    static const int SCREEN_WIDTH;
    static const int SCREEN_HEIGHT;

    int dystans_lewy() const;
    int dystans_prawy() const;
    int dystans_gora() const;
    int dystans_dol() const;

private:
    int x;
    int y;
};


class pixel_kolorowy : public pixel {
public:
    pixel_kolorowy(int x, int y, kolor_transparentny kolor);

    kolor_transparentny getKolor() const;
    void setKolor(kolor_transparentny kolor);

    void przesun(int dx, int dy);

private:
    kolor_transparentny kolor;
};

int odleglosc(const pixel& p, const pixel& q);
int odleglosc(const pixel* p, const pixel* q);
