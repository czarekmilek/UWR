/*
 * Cezary Miłek
 * zadanie 1
 * net7.0
 */

using zadanie1;

namespace ListaTestowa
{
    class Program
    {
        static void Main(string[] args)
        {
            Lista<int> lista = new Lista<int>(); // tworzymy nową listę typu int

            lista.PushFront(1); // dodajemy elementy na początek listy
            lista.PushFront(2);
            lista.PushFront(3);
            lista.PushFront(4);

            // sprawdzamy czy lista nie jest pusta
            Console.WriteLine("Lista jest pusta: " + lista.IsEmpty());

            // usuwamy elementy z początku listy i wyświetlamy je na ekranie
            Console.WriteLine("Usunięte elementy z początku listy:");
            Console.WriteLine(lista.PopFront());
            Console.WriteLine(lista.PopFront());
            Console.WriteLine(lista.PopFront());
            Console.WriteLine(lista.PopFront());

            // sprawdzamy czy lista jest pusta
            Console.WriteLine("Lista jest pusta: " + lista.IsEmpty());

            lista.PushBack(5); // Dodajemy elementy na koniec listy
            lista.PushBack(6);
            lista.PushBack(7);
            lista.PushBack(8);

            // usuwamy elementy z końca listy i wyświetlamy je na ekranie
            Console.WriteLine("Usunięte elementy z końca listy:");
            Console.WriteLine(lista.PopBack());
            Console.WriteLine(lista.PopBack());
            Console.WriteLine(lista.PopBack());
            Console.WriteLine(lista.PopBack());

            // sprawdzamy, czy lista jest pusta
            Console.WriteLine("Lista jest pusta: " + lista.IsEmpty());

            // oczekujemy na naciśnięcie klawisza aby program wciaz dzialal
            Console.ReadKey();
        }
    }
}