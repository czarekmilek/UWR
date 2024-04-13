//Cezary Milek; zadanie 4

using System;
using System.Collections.Generic;

namespace kod
{
    class ListaLeniwa
    {
        public int liczba_elem; // liczba elementów aktualnie przechowywanych w liście
        List<int> lista_int; // lista przechowująca elementy
        Random rand; // generator liczb losowych

        public ListaLeniwa()
        {   this.liczba_elem = 0;
            this.lista_int = new List<int>(); //nowa lista przechowujaca liczby
            this.rand = new Random(); //obiekt do generowania liczb
        }

        virtual public int element(int i)
        {
            if (i > this.liczba_elem) // jeśli żądany indeks przekracza aktualną liczbę elementów w liście
            {
                int reszta = i - this.liczba_elem; // oblicz, ile elementów należy dodać
                this.uzupelnij_liste_int(reszta); // uzupełnij listę o brakujące elementy
                this.liczba_elem = i; // zaktualizuj liczbę elementów
            }

            return this.lista_int[i - 1]; // zwróć żądany element
        }

        virtual public int size()
        {return this.liczba_elem; // zwróć liczbę elementów w liście
        }

        void uzupelnij_liste_int(int reszta)
        {
            while (reszta > 0) // dopóki należy dodać jeszcze jakieś elementy
            {
                this.lista_int.Add(rand.Next(-2147000000, 2147000000)); // dodaj losową liczbę do listy
                reszta--;
            }
        }
    }


    class Pierwsze : ListaLeniwa
    {
        List<int> lista_pierwszych; // lista przechowująca liczby pierwsze
        int elem; // ostatnio sprawdzana liczba

        public Pierwsze()
        {   this.lista_pierwszych = new List<int>();
            this.elem = 2;
        }

        private bool czy_pierwsza(int n)
        {
            for (int i = 2; i < n; i++)
                if (n % i == 0)
                    return false;
            return true;
        }

        override public int element(int i)
        {
            if (i > liczba_elem) // jeśli żądany indeks przekracza aktualną liczbę elementów w liście
            {
                int reszta = i - liczba_elem; // oblicz, ile elementów należy dodać
                this.uzupelnij_liste_pierwszych(reszta); // uzupełnij listę o brakujące elementy
                liczba_elem = i; // zaktualizuj liczbę elementów
            }

            return this.lista_pierwszych[i-1]; // zwróć żądany element
        }

        void uzupelnij_liste_pierwszych(int reszta)
        {
            while (reszta > 0) // dopóki należy dodać jeszcze jakieś elementy
            {
                if (czy_pierwsza(elem) == true) // jeśli liczba jest pierwsza
                {
                    this.lista_pierwszych.Add(this.elem); // dodaj ją do listy liczb pierwszych
                    reszta--;
                }
                this.elem++;
            }
            
        }
        
        override public int size()
        {    return liczba_elem;
        }
    }

class Program
{
    static void Main(string[] args)
    {
        ListaLeniwa lista = new ListaLeniwa();
        Console.WriteLine(lista.size());  // 0
        Console.WriteLine(lista.element(2));  //losowa liczba
        Console.WriteLine(lista.size());  // 2
        Console.WriteLine(lista.element(10));  // losowa liczba
        Console.WriteLine(lista.size());  // 10
        Console.WriteLine(lista.element(100));  // losowa liczba
        Console.WriteLine(lista.size());  // 100
        
        Console.WriteLine();
        
        Pierwsze pierwsze = new Pierwsze();
        Console.WriteLine(pierwsze.size());  // 0
        Console.WriteLine(pierwsze.element(10));  // 29
        Console.WriteLine(pierwsze.size());  // 10
        Console.WriteLine(pierwsze.element(5));  // 11
        Console.WriteLine(pierwsze.size());  // 10
        Console.WriteLine(pierwsze.element(15));  // 47
        Console.WriteLine(pierwsze.size());  // 15
    }
}}