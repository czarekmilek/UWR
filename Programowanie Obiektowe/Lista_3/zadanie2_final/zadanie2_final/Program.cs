/*
 * Cezary Miłek
 * zadanie 2
 */

class Program
{
    static void Main()
    {
        //test int string
        MyDictionary<int, string> dictionary = new MyDictionary<int, string>();
        Console.WriteLine("Slownik <int, string>:");
        
        Console.WriteLine("Dodaj element: klucz = 1, wartosc = 'Jeden'.");
        dictionary.Add(1, "Jeden");
        Console.WriteLine("Dodaj element: klucz = 2, wartosc = 'Dwa'.");
        dictionary.Add(2, "Dwa");
        Console.WriteLine("Dodaj element: klucz = 3, wartosc = 'Trzy'.");
        dictionary.Add(3, "Trzy");

        Console.WriteLine("Znajdz element o kluczu 1:");
        Console.WriteLine(dictionary.Get(1)); // "Jeden"
        Console.WriteLine("Znajdz element o kluczu 2:");
        Console.WriteLine(dictionary.Get(2)); // "Dwa"
        Console.WriteLine("Znajdz element o kluczu 3:");
        Console.WriteLine(dictionary.Get(3)); // "Trzy"
        
        Console.WriteLine("Usun element o kluczu 2.");
        dictionary.Remove(2);

        try
        { Console.WriteLine(dictionary.Get(2)); }
        catch (KeyNotFoundException e)
        {   Console.WriteLine("Znajdz element o kluczu 2:");
            Console.WriteLine(e.Message); } // Klucz nie zostal znaleziony.
        
        try
        { dictionary.Add(1, "Jeden ponownie"); }
        catch (ArgumentException e)
        {   Console.WriteLine("Dodaj element: klucz = 1, wartosc = 'Jeden ponownie'.");
            Console.WriteLine(e.Message); } // Element z tym kluczem juz istnieje.

        Console.WriteLine();
        
        //test string string
        MyDictionary<string, string> dictionary2 = new MyDictionary<string, string>();
        Console.WriteLine("Slownik <string, string>:");
        
        Console.WriteLine("Dodaj element: klucz = 'Jeden', wartosc = '1'.");
        dictionary2.Add("Jeden", "1");
        Console.WriteLine("Dodaj element: klucz = 'Dwa', wartosc = '2'.");
        dictionary2.Add("Dwa", "2");
        Console.WriteLine("Dodaj element: klucz = 'Trzy', wartosc = '3'.");
        dictionary2.Add("Trzy", "3");

        Console.WriteLine("Znajdz element o kluczu 'Jeden':");
        Console.WriteLine(dictionary2.Get("Jeden")); // 1
        Console.WriteLine("Znajdz element o kluczu 'Dwa':");
        Console.WriteLine(dictionary2.Get("Dwa")); // 2
        Console.WriteLine("Znajdz element o kluczu 'Trzy':");
        Console.WriteLine(dictionary2.Get("Trzy")); // 3

        Console.WriteLine("Usun element o kluczu 'Dwa'.");
        dictionary2.Remove("Dwa");

        try
        { Console.WriteLine(dictionary2.Get("Dwa")); }
        catch (KeyNotFoundException e)
        {   Console.WriteLine("Znajdz element o kluczu 'Dwa':");
            Console.WriteLine(e.Message); } // The key was not found in the dictionary.
        
        try
        { dictionary2.Add("Jeden", "1 ponownie"); }
        catch (ArgumentException e)
        {   Console.WriteLine("Dodaj element: klucz = 'Jeden', wartosc = '1 ponownie'.");
            Console.WriteLine(e.Message); } // The key was not found in the dictionary.

        Console.ReadLine();
    }
}
