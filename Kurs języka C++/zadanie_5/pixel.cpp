#include "pixel.hpp"

//SVGA
const int pixel::SCREEN_WIDTH = 800;
const int pixel::SCREEN_HEIGHT = 600;

pixel::pixel(int x, int y)
        : x{ x }, y{ y }
{
    // sprawdzenie, czy współrzędne piksela nie wychodzą poza ekran
    if (x < 0) {
        this->x = 0;
    }
    else if (x >= SCREEN_WIDTH) {
        this->x = SCREEN_WIDTH - 1;
    }

    if (y < 0) {
        this->y = 0;
    }
    else if (y >= SCREEN_HEIGHT) {
        this->y = SCREEN_HEIGHT - 1;
    }
}

int pixel::getX() const
    {return x;}

int pixel::getY() const
    {return y;}

void pixel::setX(int x)
{
    if (x < 0) {
        this->x = 0;
    }
    else if (x >= SCREEN_WIDTH) {
        this->x = SCREEN_WIDTH - 1;
    }
    else {
        this->x = x;
    }
}

void pixel::setY(int y)
{
    if (y < 0) {
        this->y = 0;
    }
    else if (y >= SCREEN_HEIGHT) {
        this->y = SCREEN_HEIGHT - 1;
    }
    else {
        this->y = y;
    }
}

int pixel::dystans_lewy() const
    {return x;}

int pixel::dystans_prawy() const
    {return SCREEN_WIDTH - x - 1;}

int pixel::dystans_gora() const
    {return y;}

int pixel::dystans_dol() const
    {return SCREEN_HEIGHT - y - 1;}


pixel_kolorowy::pixel_kolorowy(int x, int y, kolor_transparentny kolor)
        : pixel(x, y), kolor{kolor }
{}

kolor_transparentny pixel_kolorowy::getKolor() const
    {return kolor;}

void pixel_kolorowy::setKolor(kolor_transparentny kolor)
    {this->kolor = kolor;}

void pixel_kolorowy::przesun(int dx, int dy)
{
    int new_x = getX() + dx;
    int new_y = getY() + dy;

    if (new_x < 0 || new_x >= SCREEN_WIDTH || new_y < 0 || new_y >= SCREEN_HEIGHT) {
        throw out_of_range("Nowe koordynaty poza ekranem");
    }

    setX(new_x);
    setY(new_y);
}

int odleglosc(const pixel &p, const pixel &q) {
    int dx = p.getX() - q.getX();
    int dy = p.getY() - q.getY();
    return round(sqrt(dx * dx + dy * dy));
}

int odleglosc(const pixel *p, const pixel *q) {
    return odleglosc(*p, *q);
}





