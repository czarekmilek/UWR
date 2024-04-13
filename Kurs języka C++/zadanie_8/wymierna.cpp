#include "wymierna.hpp"

namespace obliczenia {

    int NWD(int a, int b) {
        if (b == 0) {
            return a;
        }
        return NWD(b, a % b);
    }

    void wymierna::skracanie_ulamka() noexcept {
        int nwd   = NWD(licznik, mianownik);
        licznik   = licznik / nwd;
        mianownik = mianownik / nwd;

        if (mianownik < 0) {
            licznik   = licznik * (-1);
            mianownik = mianownik * (-1);
        }
    }

    wymierna::wymierna() noexcept : licznik(0), mianownik(1){}

    wymierna::wymierna(int licznik, int mianownik) : licznik(licznik), mianownik(mianownik){
        if (mianownik == 0) {
            throw dzielenie_przez_0();
        }
        skracanie_ulamka();
    }

    wymierna::wymierna(int liczba) noexcept : wymierna(liczba, 1){}


    int wymierna::getLicznik() const noexcept {
        return licznik;
    }
    int wymierna::getMianownik() const noexcept {
        return mianownik;
    }

    wymierna::wymierna(const wymierna& other) noexcept : licznik(other.licznik), mianownik(other.mianownik) {}

    wymierna::wymierna(wymierna&& other) noexcept : licznik(std::move(other.licznik)), mianownik(std::move(other.mianownik)) {}

    wymierna& wymierna::operator=(const wymierna& other) noexcept {
        if (this != &other) {
            licznik   = other.licznik;
            mianownik = other.mianownik;
        }
        return *this;
    }

    wymierna& wymierna::operator=(wymierna&& other) noexcept {
        if (this != &other) {
            licznik   = std::move(other.licznik);
            mianownik = std::move(other.mianownik);
        }
        return *this;
    }


    void sprawdz_zakres(int liczba) {
        if (liczba > std::numeric_limits<int>::max() || liczba < std::numeric_limits<int>::min()) {
            throw przekroczenie_zakresu();
        }
    }

    wymierna wymierna::operator-() const noexcept{
        int nowy_licznik = this->licznik * -1;
        return wymierna(nowy_licznik, this->mianownik);
    }

    wymierna wymierna::operator!() const {
        if (this->licznik == 0) {
            throw dzielenie_przez_0();
        }
        int nowy_licznik   = mianownik;
        int nowy_mianownik = licznik;
        return wymierna(nowy_licznik, nowy_mianownik);
    }

    wymierna wymierna::operator+(const wymierna& liczba) const {
        int nowy_licznik   = int(this->licznik * liczba.mianownik) + int(liczba.licznik * this->mianownik);
        int nowy_mianownik = int(this->mianownik * liczba.mianownik);

        sprawdz_zakres(nowy_licznik);
        sprawdz_zakres(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna& wymierna::operator+=(const wymierna& liczba) {
        *this = *this / liczba;
        return *this;
    }

    wymierna wymierna::operator-(const wymierna& liczba) const {
        int nowy_licznik   = int(this->licznik * liczba.mianownik) - int(liczba.licznik * this->mianownik);
        int nowy_mianownik = int(this->mianownik * liczba.mianownik);

        sprawdz_zakres(nowy_licznik);
        sprawdz_zakres(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna& wymierna::operator-=(const wymierna& liczba) {
        *this = *this / liczba;
        return *this;
    }

    wymierna wymierna::operator*(const wymierna& liczba) const {
        int nowy_licznik   = int(this->licznik * liczba.licznik);
        int nowy_mianownik = int(this->mianownik * liczba.mianownik);

        sprawdz_zakres(nowy_licznik);
        sprawdz_zakres(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna& wymierna::operator*=(const wymierna& liczba) {
        *this = *this / liczba;
        return *this;
    }

    wymierna wymierna::operator/(const wymierna& liczba) const {
        if (liczba.licznik == 0){
            throw dzielenie_przez_0();
        }
        int nowy_licznik   = int(this->licznik * liczba.mianownik);
        int nowy_mianownik = int(this->mianownik * liczba.licznik);

        sprawdz_zakres(nowy_licznik);
        sprawdz_zakres(nowy_mianownik);

        return wymierna(int(nowy_licznik), int(nowy_mianownik));
    }

    wymierna& wymierna::operator/=(const wymierna& liczba) {
        *this = *this / liczba;
        return *this;
    }

    wymierna::operator double() const noexcept {
        return double(licznik) / double(mianownik);
    }

    wymierna::operator int() const noexcept {
        return licznik / mianownik;
    }

    std::ostream& operator<< (std::ostream& wyjscie, const wymierna& lb) noexcept {
        int licznik   = lb.licznik;
        int mianownik = lb.mianownik;

        if (licznik == 0) {
            return wyjscie << 0;
        }

        else if (licznik < 0) {
            wyjscie << "-";
        }

        licznik   = abs(licznik);
        mianownik = abs(mianownik);

        int calkowita = licznik / mianownik;
        int ulamkowa  = licznik % mianownik;
        std::string str_ulamkowa = "";
        std::map<int, int> prev_ulamkowa;

        wyjscie << calkowita << ".";

        while (ulamkowa != 0 && prev_ulamkowa.find(ulamkowa) == prev_ulamkowa.end()) {
            prev_ulamkowa[ulamkowa] = str_ulamkowa.length(); //pozycja gdzie pierwszy raz pojawia sie po raz 1.
            ulamkowa      = ulamkowa * 10;
            int cyfra     = ulamkowa / mianownik;
            ulamkowa      = ulamkowa % mianownik;
            str_ulamkowa += std::to_string(cyfra);
        }

        if (prev_ulamkowa.find(ulamkowa) != prev_ulamkowa.end()) {
            int poczatek_cyklicznosci = prev_ulamkowa[ulamkowa];
            str_ulamkowa = str_ulamkowa.substr(0, poczatek_cyklicznosci) + "(" + str_ulamkowa.substr(poczatek_cyklicznosci) + ")";
        }

        if (str_ulamkowa == "") {
            wyjscie << 0;
        }
        else {
            wyjscie << str_ulamkowa;
        }

        return wyjscie;
    }
}