/*
Cezary Miłek
zadanie 4, lista 6
Program wykonania zadania:
IntelliJ IDEA Community Edition 2022.3.3
*/

public class Konsument extends Thread
{
    Bufor<String> Bufor; // bufor, z którego konsument pobiera elementy
    int maxElems; // maksymalna liczba elementów w buforze
    int countSaved; // liczba elementów pobranych z bufora

    public Konsument(Bufor<String> Bufor) {
        this.maxElems = Bufor.maxCapacity; // inicjalizacja maksymalnej liczby elementów buforu
        this.Bufor = Bufor; // inicjalizacja bufora
        countSaved = 0; // ustawiamy początkową liczbę pobranych elementów na 0
    }

    @Override
    public void run() {
        while (true)
        {
            try {
                // odczytujemy element z buforu i wyświetlamy na ekranie
                System.out.println("Konsument: " + Bufor.save());
                countSaved++;
            } catch (InterruptedException e) {
                // sprawdzamy czy wait() użyte czy nie
            }

            // jeśli odczytaliśmy już tyle elementów, ile było maksymalnie możliwe do odczytania, to kończymy działanie
            if (this.countSaved == this.maxElems)
                return;
        }
    }
}
