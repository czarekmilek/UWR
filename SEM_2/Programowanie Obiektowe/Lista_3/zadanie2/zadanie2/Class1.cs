/*
 * Cezary Miłek
 * zadanie 2
 */

public class MyDictionary<K, V> //K - typ kluczy, V - typ wartosci
{
    private List<K> keys; //lista kluczy
    private List<V> values; //lista wartosci

    public MyDictionary() //konstruktor
    {
        keys = new List<K>(); //pusta lista kluczy
        values = new List<V>(); //pusta lista wartosci
    }

    public void Add(K key, V value) //dodanie nowego elementu o okreslonym kluczu i wartosci
    {
        if (keys.Contains(key))
        { throw new ArgumentException("Element z tym kluczem juz istnieje."); }

        keys.Add(key); //dodajemy klucz do listy kluczy
        values.Add(value); //dodajemy wartosc do listy wartosci
    }

    public V Get(K key) //zwrot wartosci elementu o okreslonym kluczu
    {
        int index = keys.IndexOf(key); //znajdujemy indeks klucza w liscie kluczy
        if (index == -1)
        { throw new KeyNotFoundException("Klucz nie zostal znaleziony."); }

        return values[index]; //zwracamy wartosc o tym samym indeksie co klucz
    }

    public void Remove(K key) //usuniecie elementu o okreslonym kluczu
    {
        int index = keys.IndexOf(key); //znajdujemy indeks klucza w liscie kluczy
        if (index == -1)
        { throw new KeyNotFoundException("Klucz nie zostal znaleziony."); }

        keys.RemoveAt(index); //usuwamy klucz o znalezionym indeksie
        values.RemoveAt(index); //usuwamy wartosc o znalezionym indeksie
    }
}