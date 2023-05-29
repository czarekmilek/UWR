#ifndef wszystko_HPP
#define wszystko_HPP

#include <cmath>
#include <exception>
#include <iostream>
#include "punkt.hpp"
#include "odcinek.hpp"
#include "trojkat.hpp"


double dlugosc(punkt a, punkt b);
bool czyRownolegle(odcinek c, odcinek d);
bool czyProstopadle(odcinek c, odcinek d);
int orientacja(punkt a, punkt b, punkt c); // do przecinania sie odcinkow
bool czyPrzecina(odcinek c, odcinek d);
bool czyTrojkatyZawierajaSie(trojkat u, trojkat v);
bool czyTrojkatyPrzecinajaSie(trojkat u, trojkat v);

#endif //wszystko_HPP
