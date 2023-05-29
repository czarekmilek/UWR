using System;
using System.Collections;

public class SlowaFibonacciego : IEnumerable<string>
{
    private readonly int n;

    public SlowaFibonacciego(int n) 
    {
        this.n = n;
    }

    public IEnumerator<string> GetEnumerator()
    {
        string a = "a";
        string b = "b";
        if (n >= 1) yield return b; 
        if (n >= 2) yield return a; 
        if (n >= 3) 
        {
            for (int i = 3; i <= n; i++)
            {
                string c = b + a; // zmienna c = suma stringów b i a
                yield return c; // zwróć wartość zmiennej c
                b = a; 
                a = c; 
            }
        }
    }

    IEnumerator IEnumerable.GetEnumerator() 
    {
        return GetEnumerator(); // zwróć enumerator
    }
}

class Program
{
    static void Main(string[] args) 
    {
        SlowaFibonacciego sf = new SlowaFibonacciego(13);
        foreach (string s in sf) 
        {
            Console.WriteLine(s); 
        }
    }
}