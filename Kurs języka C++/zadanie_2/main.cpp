#include <iostream>
#include <cmath>
#include "punkt.hpp" //rzeczy zwiazane z punktem
#include "odcinek.hpp" //rzeczy zwiazane z odcinkiem
#include "trojkat.hpp" //rzeczy zwiazane z trojkatem
#include "wszystko.hpp" //rzeczy pozostale, korzystajace z wszystkich poprzednich

using namespace std;

int main()
{
    cout << "Test klasy 'punkt': " << endl;
    punkt point1(3.3, 4.7);
    punkt point2;
    punkt point3(point1);
    cout << "Poczatkowe punkty point1 i point2: " << point1 << " i " << point2 << endl;
    cout << "Kopia punktu point1: " << point3 << endl;
    point1.przesun(6.4, -9.2);
    point2.przesun(6.4, -9.2);
    cout << "Po przesunieciu o (6.4, -9.2): " << point1 << " i " << point2 << endl;
    point1.obroc(0, 0, M_PI);
    point2.obroc(0, 0, M_PI);
    cout << "Po rotacji o pi (koordynaty (0,0)): " << point1 << " i " << point2 <<  endl;
    point1.setX(5);
    point2.setY(0);
    cout << "Point1 po zamianie wartosci X na 5: " << point1 << endl;
    cout << "Point2 po zamianie wartosci Y na 0: " << point2 << endl;
    cout << "Wspolrzedna x point1: " << point1.getX() << endl;
    cout << "Wspolrzedna y point1: " << point1.getY() << endl;

    prosta liniowa(0,0,1,1);
    punkt p1(1,5);
    cout << "Punkt p1 przed obrotem wzgledem f(x) = x: " << p1 << endl;
    p1.osSymetrii(liniowa);
    cout << "Punkt p1 po obrocie: " << p1 << endl; //nie wiem czemu nan

    punkt test_osSrodkowa(5, -91);
    cout << "Punkt test_osSrodkowa przed symetria srodkowa: " << test_osSrodkowa << endl;
    test_osSrodkowa.symetria_srodkowa(test_osSrodkowa);
//    test_osSrodkowa.obroc(0,0, M_PI);
    cout << "Punkt test_osSrodkowa po: " << test_osSrodkowa << endl;

    cout << endl << "Test klasy 'odcinek': " << endl;
    odcinek odc01, odc02;
    odcinek odc1(0, 0, 8, 16);
    odcinek odc2(punkt(2,3), punkt(5,8));
    odcinek odc3(odc1);
    cout << "odc01: " << odc01 << "\n" << "odc1: " << odc1 << "\n" << "odc2: " << odc2 << "\n" << "odc3: " << odc3 << endl;
    cout << "Kopia odcinka odc1: " << odc3 << endl;
    odc1.przesun(0.3, 4.1);
    cout << "Po przesunieciu o wektor (0.3, 4.1): " << odc1 << endl;
    odc02.obroc(0, 0, M_PI);
    cout << "Po rotacji o pi odcinka odc02 = odc01 (koordynaty (0, 0): " << odc02 <<  endl;
    cout << "Dlugosc odcinka 'odc01' = " << odc01.dlugosc() << endl;
    punkt mittel = odc01.srodek();
    cout << "Srodek odcinka 'odc01' " << odc01 << " to " << mittel << endl;
    cout << "Pierwszy punkt odcinka odc1: " << odc1.getA() << endl;
    cout << "Drugi punkt odcinka odc1: " << odc1.getB() << endl;
    cout << "Punkt " << punkt(0, 0) << (odcinek(2,0,5,0).nalezy(punkt(0,0)) ? " nalezy " : " nie nalezy ") << "do odcinka " << odcinek(2,0,5,0) << endl;
    cout << "Punkt " << punkt(3, 0) << (odcinek(2,0,5,0).nalezy(punkt(3,0)) ? " nalezy " : " nie nalezy ") << "do odcinka " << odcinek(2,0,5,0) << endl;
    cout << "Odcinek odc1 i odc2" << (czyPrzecina(odc1, odc2) ? " przecinaja sie " : " nie przecinaja sie ") << endl;
    odcinek odc_test1(punkt(0,0), punkt(3,0));
    odcinek odc_test2(punkt(1, 1), punkt(1, -1));
    cout << "Odcinek odc_test1 i odc_test2" << (czyPrzecina(odc_test1, odc_test2) ? " przecinaja sie " : " nie przecinaja sie ") << endl;

    cout << endl << "Test klasy 'trojkat': " << endl;
    trojkat tri1(0, 0, 0, 3, 5, 0);
    trojkat tri2(punkt(1,1), punkt(1,2), punkt(3,0));
    cout << "Pierwszy trojkat: " << tri1 << endl;
    cout << "Pierwszy wierzcholek pierwszego trojkata: " << tri1.getA() << endl;
    cout << "Drugi wierzcholek pierwszego trojkata: " << tri1.getB() << endl;
    cout << "Trzeci wierzcholek pierwszego trojkata: " << tri1.getC() << endl;
    cout << "Drugi trojkat: " << tri2 << endl;
    cout << "Pole pierwszego trojkata: " << tri1.pole() << endl;
    cout << "Pole drugiego trojkata: " << tri2.pole() << endl;
    cout << "Obwod pierwszego trojkata: " << tri1.obwod() << endl;
    cout << "Obwod drugiego trojkata: " << tri2.obwod() << endl;
    punkt tri_test(1, 1);
    punkt tri_test2(292, 19);
    cout << "Punkt " << tri_test << " jest " << (tri1.czyWsrodku(tri_test) ? "wewnatrz" : "na zewnatrz") << " trojkata." << endl;
    cout << "Trojkaty tri1 i tri2 " << (czyTrojkatyPrzecinajaSie(tri1, tri2) ? "przecinaja sie" : "nie przecinaja sie") << endl;
    cout << "Trojkaty tri1 i tri2 " << (czyTrojkatyZawierajaSie(tri1, tri2) ? "zawieraja sie " : "nie zawieraja sie") << endl;
    cout << "Srodek pierwszego trojkata to " << tri1.srodek() << endl;
    tri1.obroc(punkt(0,0), M_PI/2 );
    cout << "Pierwszy trojkat po rotacji: " << tri1 << endl;
    tri2.przesun(12, 7);
    cout << "Drugi trojkat po przesunieciu o (12, 7): " << tri2 << endl;


    cout << endl << "Test klasy 'wszystko': " << endl;
    odcinek a(punkt(0,0), punkt(6, 0));
    odcinek b(punkt(1,0), punkt(8, 0));
    cout << "Odcinek a: " << a << " i b: " << b << (czyRownolegle(a, b) ? " sa " : " nie sa ") << "rownolegle." << endl;
    odcinek a_copy(a);
    odcinek b_2(punkt(0,0), punkt(0, 3));
    cout << "Odcinek a: " << a_copy << " i b: " << b_2 << (czyProstopadle(a_copy, b_2) ? " sa " : " nie sa ") << "prostopadle." << endl;

    return 0;
}
