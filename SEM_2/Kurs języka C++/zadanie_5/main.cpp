#include "kolor.hpp"
#include "pixel.hpp"


int main() {
    cout << "Test klasy 'kolor':" << endl;

    kolor k1;
    cout << "k1 = " << k1 << endl;

    kolor k2(100, 200, 255);
    cout << "k2 = " << k2 << endl;

    kolor k3(128, 64, 32);
    cout << "k3 przed zmianami: " << k3 << endl;

    k3.rozjasnij(50);
    cout << "k3 po zmianach: (" << k3 << endl;

    k3.przyciemnij(100);
    cout << "k3 przed przyciemnieniem: " << k3 << endl;

    try {
        kolor k3(300, 400, 500);
    }
    catch (out_of_range& e) {
        cout << e.what() << endl;
    }
    cout << endl;

    cout << "Test klasy 'kolor_transparentny':" << endl;
    kolor_transparentny kt1;
    kt1.setRed(255);
    kt1.setGreen(0);
    kt1.setBlue(0);
    kt1.setAlpha(128);

    cout << "kt1: " << kt1 << endl;

    kolor_transparentny kt2(k1, 128);
    cout << "kt2: " << kt2.getAlpha() << endl;

    try {
        kolor_transparentny kt3(0, 0, 0, 370);
    }
    catch (out_of_range& e) {
        cout << e.what() << endl;
    }
    cout << endl;


    cout << "Test klasy 'kolor_nazwany':" << endl;
    kolor_nazwany bialy(255, 255, 255, "white");
    cout << "Nazwa koloru bialy: " << bialy.getName() << endl;

    kolor_nazwany zielony(255, 255, 0, "green");
    cout << "Nazwa koloru zielony: " << zielony.getName() << endl;

    try {
        kolor_nazwany czarny(0, 0, 0, "black");
    }
    catch (out_of_range& e) {
        cout << e.what() << endl;
    }
    cout << endl;


    cout << "Test klasy 'kolor_nt':" << endl;

    kolor_nt knt1(255, 0, 0, 128, "red");
    cout << "knt1: " << knt1 << endl;
    cout << endl;


    cout << "Test klasy 'pixel':" << endl;
    pixel p(3, 4);
    cout << "Koordynaty pixela: (" << p.getX() << ", " << p.getY() << ")" << endl;
    cout << "Dystans do lewego brzegu: " << p.dystans_lewy() << endl;
    cout << "Dystans do prawego brzegu: " << p.dystans_prawy() << endl;
    cout << "Dystans do gornego brzegu: " << p.dystans_gora() << endl;
    cout << "Dystans do dolnego brzegu: " << p.dystans_dol() << endl;
    cout << endl;

    cout << "Test klasy 'pixel_kolorowy':" << endl;
    pixel_kolorowy pk(10, 20, kolor_transparentny(255, 0, 0, 128));

    // Wyświetlamy współrzędne piksela i jego kolor
    cout << "Koordynaty pixela pk: (" << pk.getX() << ", " << pk.getY() << ")" << endl;

    cout << "Kolor pixela pk: (" << pk.getKolor().getRed() << ", " << pk.getKolor().getGreen() << ", "
         << pk.getKolor().getBlue() << ", " << pk.getKolor().getAlpha() << ")" << endl;

    try {
        pk.przesun(-1000, 10);
        cout << "Nowe koordynaty pixela pk: (" << pk.getX() << ", " << pk.getY() << ")" << endl;
    }
    catch (const out_of_range& e) {
        cerr << "Wyjatek: " << e.what() << endl;
    }
    cout << endl;

    cout << "Test funkcji globalnych:" << endl;
    pixel p1(1, 2);
    pixel p2(3, 4);
    pixel* ptr1 = &p1;
    pixel* ptr2 = &p2;

    cout << "Dystans miedzy p1 a p2: " << odleglosc(p1, p2) << endl;
    cout << "Dystans miedzy p1 a p2 (wskazniki): " << odleglosc(ptr1, ptr2) << endl;


}