#include "liczba.hpp"

//konstruktor domyslny
liczba::liczba() : m_value(0.0), m_history(nullptr), m_history_size(0), m_history_pos(0) {}

//konstruktor z wartosci
liczba::liczba(double value) : m_value(value), m_history(new double[max_history_size]), m_history_size(max_history_size), m_history_pos(0) {
    push_history(value);
}

//konstruktor kopiujacy
liczba::liczba(const liczba& other) : m_value(other.m_value), m_history(new double[max_history_size]), m_history_size(max_history_size), m_history_pos(0) {
    push_history(m_value);
}

//konstruktor przenoszacy
liczba::liczba(liczba&& other) noexcept : m_value(other.m_value), m_history(other.m_history), m_history_size(other.m_history_size), m_history_pos(other.m_history_pos) {
    other.m_history = nullptr;
}

//operator przypisania
liczba& liczba::operator=(const liczba& other) {
    if (this != &other) {
        m_value = other.m_value;
        m_history_pos = 0;
        push_history(m_value);
    }
    return *this;
}

//operator przeniesienia
liczba& liczba::operator=(liczba&& other) noexcept {
    if (this != &other) {
        m_value = other.m_value;
        m_history = other.m_history;
        m_history_size = other.m_history_size;
        m_history_pos = other.m_history_pos;
        other.m_history = nullptr;
    }
    return *this;
}

//destruktor
liczba::~liczba() {
    delete[] m_history;
}

//zwrot wartosci
double liczba::get_value() const {
    return m_value;
}

//ustawianie wartosci
void liczba::set_value(double value) {
    push_history(m_value);
    m_value = value;
}

//przywrocenie ostatniej wartosci
void liczba::restore_last_value() {
    if (m_history_pos == 0) {
        throw std::logic_error("no value to restore in history");
    }
    m_value = m_history[--m_history_pos];
}

//dodanie wartosci do historii
void liczba::push_history(double value) {
    if (m_history_size == 0) {
        return;
    }
    m_history[m_history_pos++] = value;
    if (m_history_pos == m_history_size) {
        m_history_pos = 0;
    }
}

//zwrócenie wartości z historii o podanym indeksie
double liczba::get_history_value(int index) const {
    if (index >= m_history_size || index >= m_history_pos) {
        throw std::out_of_range("index out of range");
    }
    int history_index = m_history_pos - index - 1;
    if (history_index < 0) {
        history_index += m_history_size;
    }
    return m_history[history_index];
}

