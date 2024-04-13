/*
Cezary Miłek
zadanie 4, lista 6
Program wykonania zadania:
IntelliJ IDEA Community Edition 2022.3.3
 */

public class Merge_Sort implements Runnable
{
    int[] tablica; //nieposortowana tablica liczb całkowitych
    int[] temp_tablica; //tablica tymczasowa
    int poczatek; //inedks poczatkowy
    int koniec; //indeks koncowy

    //konstruktor klasy Merge_Sort,
    // inicjuje zmienne klasy i tworzy tablicę tymczasową o rozmiarze koniec+1
    Merge_Sort(int[] tablica, int poczatek, int koniec)
    {
        this.tablica = tablica;
        this.poczatek = poczatek;
        this.koniec   = koniec;

        temp_tablica = new int [koniec + 1];
    }

    //funkcja Merge(), która scala dwie posortowane podtablice w jedną posortowaną tablicę
    private void Merge()
    {
        int i, j, k;
        int srednia = (poczatek + koniec) / 2;

        for (i = poczatek; i <= koniec; i++) //kopia z nieposortowanej tablicy do tablicy tymczasowej
            temp_tablica[i] = tablica[i];

        i = poczatek;
        j = srednia + 1;
        k = poczatek;

        while (i <= srednia && j <= koniec) //scalanie dwóch podtablic w jedną
        {
            if (temp_tablica[i] < temp_tablica[j])
                tablica[k++] = temp_tablica[i++];
            else
                tablica[k++] = temp_tablica[j++];
        }

        //jeśli któraś z podtablic nie została przetworzona w całości,
        // to pozostałe elementy dodawane są do tablicy wynikowej
        while (i <= srednia)
            tablica[k++] = temp_tablica[i++];

        while (j <= koniec)
            tablica[k++] = temp_tablica[j++];
    }


    //funkcja run() sortująca połówki tablicy, a następnie scalająca je w jedną
    public void run()
    {
        if (poczatek < koniec)
        {
            // wyznaczenie środkowego elementu przedziału
            int srednia = (poczatek + koniec) / 2;

            //wywołanie algorytmu dla lewej połowy przedziału
            Merge_Sort sort_lewo  = new Merge_Sort(tablica, poczatek, srednia);

            //wywołanie algorytmu dla prawej połowy przedziału
            Merge_Sort sort_prawo = new Merge_Sort(tablica, srednia + 1, koniec);

            // utworzenie wątków dla lewej i prawej połowy przedziału
            Thread thread_lewo  = new Thread(sort_lewo);
            Thread thread_prawo = new Thread(sort_prawo);

            // uruchomienie wątków
            thread_lewo.start();
            thread_prawo.start();

            try {
                // oczekiwanie na zakończenie pracy wątku sort_lewo
                thread_lewo.join();
            } catch (InterruptedException e) {
                // obsługa wyjątku w przypadku przerwania oczekiwania
                e.printStackTrace();
            }

            try {
                // oczekiwanie na zakończenie pracy wątku sort_prawo
                thread_prawo.join();
            } catch (InterruptedException e) {
                // obsługa wyjątku w przypadku przerwania oczekiwania
                e.printStackTrace();
            }

            // scalenie posortowanych lewej i prawej połowy przedziału
            Merge();
        }
    }
}