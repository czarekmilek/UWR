#pragma once
#include <iostream>
#include <limits>
#include <map>


namespace obliczenia {
    class wymierna {
    private:
        int licznik;
        int mianownik;
        void skracanie_ulamka() noexcept;
    public:
        wymierna() noexcept;
        wymierna(int licznik, int mianownik);
        wymierna(int liczba) noexcept;
        wymierna(const wymierna& other) noexcept; //konstruktor kopiujacy
        wymierna(wymierna&& other) noexcept; //kosntruktor przenoszacy
        wymierna& operator=(const wymierna& other) noexcept; //operator kopiujacy
        wymierna& operator=(wymierna&& other) noexcept; //operator przenoszacy
        int getLicznik() const noexcept;
        int getMianownik() const noexcept;
        wymierna operator-() const noexcept;
        wymierna operator!() const;
        wymierna operator+(const wymierna& liczba) const;
        wymierna& operator+=(const wymierna& liczba);
        wymierna operator-(const wymierna& liczba) const;
        wymierna& operator-=(const wymierna& liczba);
        wymierna operator*(const wymierna& liczba) const;
        wymierna& operator*=(const wymierna& liczba);
        wymierna operator/(const wymierna& liczba) const;
        wymierna& operator/=(const wymierna& liczba);
        operator double() const noexcept;
        explicit operator int() const noexcept;
        friend std::ostream& operator<< (std::ostream& wyjscie, const wymierna& w) noexcept;
    };

    class wyjatek : public std::logic_error {
    public:
        wyjatek(const std::string& msg) : std::logic_error(msg) {}
    };

    class dzielenie_przez_0 : public wyjatek {
    public:
        dzielenie_przez_0()
                : wyjatek("Dzielenie przez 0 jest zakazane!") {}
    };

    class przekroczenie_zakresu : public wyjatek {
    public:
        przekroczenie_zakresu()
                : wyjatek("Poza zakresem!") {}
    };

}