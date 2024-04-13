/*
Cezary Miłek
zadanie 4, lista 6
Program wykonania zadania:
IntelliJ IDEA Community Edition 2022.3.3
 */

import java.util.ArrayList;

public class Bufor<T>
{
    ArrayList<T> list; // lista przechowująca elementy dodane do bufora
    public int maxCapacity; // maksymalna pojemność bufora
    int countElems; // aktualna liczba elementów w buforze

    public Bufor(int maxCapacity)
    {
        this.maxCapacity = maxCapacity; // inicjalizacja maksymalnej pojemności bufora
        this.list = new ArrayList<T>(maxCapacity); // inicjalizacja listy z maksymalną pojemnością
        countElems = 0; // inicjalizacja licznika elementów
    }

    public synchronized void insert (T elem) throws InterruptedException
    {
        while (this.Pelny() == true) // gdy bufor pełny, czeka na powiadomienie o zwolnieniu miejsca
            wait(); // metoda wait() zawiesza bieżący wątek i oczekuje na powiadomienie

        list.add(elem); // dodanie elementu do listy
        countElems++; // zwiększenie liczby elementów w buforze
        notify(); // powiadomienie wątku czekającego na pobranie elementu z bufora
        return;
    }

    public synchronized T save () throws InterruptedException
    {
        while (this.Pusty() == true) // gdy bufor jest pusty, czeka na powiadomienie o dodaniu nowego elementu
            wait(); // metoda wait() zawiesza bieżący wątek i oczekuje na powiadomienie

        countElems--; // zmniejszenie liczby elementów w buforze
        notify(); // powiadomienie wątku czekającego na dodanie elementu do bufora
        return list.remove(0); // zwrócenie i usunięcie pierwszego elementu z listy
    }

    public boolean Pelny()
    {
        if (countElems == maxCapacity) // jeśli liczba elementów w buforze jest równa maksymalnej pojemności, bufor jest pełny
            return true;
        else
            return false;
    }

    public boolean Pusty()
    {
        if (countElems == 0) // jeśli liczba elementów w buforze wynosi zero, bufor jest pusty
            return true;
        else
            return false;
    }
}
