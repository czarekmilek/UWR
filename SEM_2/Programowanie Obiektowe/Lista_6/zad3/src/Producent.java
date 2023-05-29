/*
 * Cezary Miłek
 * zadanie 4, lista 6
 * Program wykonania zadania:
 * IntelliJ IDEA Community Edition 2022.3.3
 */

public class Producent extends Thread
{
    Bufor<String> Bufor; // bufor, do którego producent będzie dodawał elementy
    int maxElems; // maksymalna liczba elementów, jakie producent może wyprodukować
    int countProduced; // aktualna liczba wyprodukowanych elementów

    public Producent(Bufor<String> Bufor)
    {
        this.maxElems = Bufor.maxCapacity; // inicjalizacja maksymalnej liczby elementów do wyprodukowania
        this.Bufor = Bufor; // inicjalizacja bufora, do którego będą dodawane elementy
        countProduced = 0; // inicjalizacja licznika wyprodukowanych elementów
    }

    @Override
    public void run()
    {
        while (true)
        {
            try
            {
                Bufor.insert("Producent: " + String.valueOf(countProduced)); // dodanie nowego elementu do bufora
                countProduced++; // zwiększenie licznika wyprodukowanych elementów
            }
            catch (InterruptedException e)
            {
                // sprawdzamy czy wait() użyte czy nie
            }
            if (this.countProduced == this.maxElems) // gdy liczba wyprodukowanych elementów jest równa maksymalnej liczbie elementów
                return; // przerywamy pracę producenta
        }
    }
}
