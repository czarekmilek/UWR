/*
 * Cezary Miłek
 * zadanie 1
 * net7.0
 */

// namespace zadanie1;

public class Lista<T>
{
    private class Node                  //klasa przechowująca elementy listy
    {   public T Value;
        public Node Next;
        public Node Previous;

        public Node(T value)            //konstruktor wartosci elementu
        { Value = value; }
    }

    private Node first;                 //1. element listy
    private Node last;                  //ostatni element listy

    public void PushFront(T element)    //metoda dodajaca element na początku listy
    {
        Node node = new Node(element);  //nowy element listy
        
        if (first == null)              // jesli lista pusta to 1. == ostatni == null
        { first = last = node; }
        else                            // wpp nowy element na poczatek
        {   node.Next = first;
            first.Previous = node;
            first = node;
        }
    }

    public void PushBack(T element)     //metoda dodajaca element na koniec listy
    {
        Node node = new Node(element);  //nowy element listy
        
        if (last == null)               // jesli lista pusta to 1. == ostatni == null
        { first = last = node; }
        else                            // wpp nowy element na poczatek
        {   node.Previous = last;
            last.Next = node;
            last = node;
        }
    }

    public T PopFront()                 // metoda zwrocenia i usuniecia pierwszego elementu listy
    {
        if (first == null)              //jesli lista jest pusta to rzucamy wyjątek
        { throw new InvalidOperationException("Lista jest pusta"); }

        T value = first.Value;          // zapis wartosci pierwszego elementu
        
        if (first == last)              // jesli lista pusta to 1. == ostatni == null
        { first = last = null; }
        else                            // wpp ustawiamy wskaznik first na następny element
        {   first = first.Next; 
            first.Previous = null;
        }
        
        return value;                   // zwracamy wartosc pierwszego elementu
    }

    public T PopBack()                  // metoda zwracajaca i usuwająca ostatni element listy
    {
        if (last == null)               //jesli lista jest pusta, to rzucamy wyjątek
        { throw new InvalidOperationException("Lista jest pusta"); }

        T value = last.Value;           // zapis wartosci pierwszego elementu
        
        if (first == last)              // jesli lista pusta to 1. == ostatni == null
        { first = last = null; }
        else                            // wpp ustawiamy wskaznik last na poprzedni elemene
        {   last = last.Previous;
            last.Next = null;
        }
        
        return value;                   // zwracamy wartosc ostatniego elementu
    }

    public bool IsEmpty()               // metoda zwracająca informacje czy lista jest pusta
    { return first == null; }
    
}
