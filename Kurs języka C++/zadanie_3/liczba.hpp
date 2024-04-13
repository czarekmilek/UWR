#ifndef LICZBA_HPP
#define LICZBA_HPP

#include <stdexcept>

class liczba {
public:
    liczba(); //kosntruktor podstawowy
    liczba(double value); //konstruktor z wartosci
    liczba(const liczba& other); //kontruktor kopiujacy
    liczba(liczba&& other) noexcept; //konstruktor przenoszacy
    liczba& operator=(const liczba& other); // operator przypisania
    liczba& operator=(liczba&& other) noexcept; //operator przeniesienia
    ~liczba(); //destruktor

    double get_value() const; //zwrot wartosci
    void set_value(double value); //ustawienie wartosci
    void restore_last_value(); //przywrocenie poprzedniej wartosci
    double get_history_value(int index) const;
private:
    static constexpr std::size_t max_history_size = 11;

    double m_value; //aktualna wartosc liczby
    double* m_history; //wskaznik na tablice sluzacej do przechowywania historii
    std::size_t m_history_size; //rozmiar historii
    std::size_t m_history_pos; //pozycja na ktorej jest obecna wartosc historii

    void push_history(double value); //dodanie wartosci do historii
};

#endif // LICZBA_HPP
