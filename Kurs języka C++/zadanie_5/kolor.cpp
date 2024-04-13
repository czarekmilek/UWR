#include "kolor.hpp"

kolor::kolor() : red(0), green(0), blue(0) {}

kolor::kolor(int r, int g, int b) {
    if (r < 0 || r > 255 || g < 0 || g > 255 || b < 0 || b > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
    red = r;
    green = g;
    blue = b;
}

int kolor:: getRed() const {
    return red;
}

int kolor::getGreen() const {
    return green;
}

int kolor::getBlue() const {
    return blue;
}

void kolor::setRed(int r) {
    if (r < 0 || r > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
    red = r;
}

void kolor::setGreen(int g) {
    if (g < 0 || g > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
    green = g;
}

void kolor::setBlue(int b) {
    if (b < 0 || b > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
    blue = b;
}

void kolor::rozjasnij(int value) {
    red = min(red + value, 255);
    green = min(green + value, 255);
    blue = min(blue + value, 255);
}

void kolor::przyciemnij(int value) {
    red = max(red - value, 0);
    green = max(green - value, 0);
    blue = max(blue - value, 0);
}

//średnia arytmetyczna poszczególnych barw
static kolor lacz(kolor k1, kolor k2) {
    int r = (k1.getRed() + k2.getRed()) / 2;
    int g = (k1.getGreen() + k2.getGreen()) / 2;
    int b = (k1.getBlue() + k2.getBlue()) / 2;
    return kolor(r, g, b);
}

kolor_transparentny::kolor_transparentny() : kolor(), alpha(0) {
    if (alpha < 0 || alpha > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
}

kolor_transparentny::kolor_transparentny(int r, int g, int b, int a) : kolor(r, g, b), alpha(a) {
    if (alpha < 0 || alpha > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
}

kolor_transparentny::kolor_transparentny(const kolor& Kolor, int a) : kolor(Kolor), alpha(a) {
    if (alpha < 0 || alpha > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
}

int kolor_transparentny::getAlpha() const {
    return alpha;
}

void kolor_transparentny::setAlpha(int a) {
    if (alpha < 0 || alpha > 255) {
        throw out_of_range("Akceptowane wartosci: 0-255");
    }
    alpha = a;
}

kolor_nazwany::kolor_nazwany() : kolor(), name("") {}

kolor_nazwany::kolor_nazwany(int r, int g, int b, const string& name) : kolor(r, g, b), name(name) {
}

string kolor_nazwany::getName() const {
    return name;
}

void kolor_nazwany::setName(const string& name) {
    for (char c : name) {
        if (c < 'a' || c > 'z') {
            throw invalid_argument("Niewlasciwa nazwa");
        }
    }
    this->name = name;
}

kolor_nt::kolor_nt() : kolor_transparentny(), kolor_nazwany() {}

kolor_nt::kolor_nt(int r, int g, int b, int a, const string& name)
        : kolor_transparentny(r, g, b, a), kolor_nazwany(r, g, b, name) {}

void kolor_nt::setAlpha(int a) {
    kolor_transparentny::setAlpha(a);
}

void kolor_nt::setName(const string& name) {
    kolor_nazwany::setName(name);
}

std::ostream& operator<<(std::ostream& os, const kolor& k) {
    return os << "(" << k.getRed() << ", " << k.getGreen() << ", " << k.getBlue() << ")";
}
std::ostream& operator<<(std::ostream& os, const kolor_transparentny& k) {
    return os << "(" << k.getRed() << ", " << k.getGreen() << ", " << k.getBlue() << ", " << k.getAlpha() << ")";
}
std::ostream& operator<<(std::ostream& os, const kolor_nazwany& k) {
    return os << "Nazwa: " << k.getName() << ", RGB: (" << k.getRed() << ", " << k.getGreen() << ", " << k.getBlue() << ")";
}
std::ostream& operator<<(std::ostream& os, const kolor_nt& k) {
    return os << "Nazwa: " << k.getName() << ", RGBA: (" << k.getRed() << ", " << k.getGreen() << ", " << k.getBlue() << ", " << k.getAlpha() << ")";
}