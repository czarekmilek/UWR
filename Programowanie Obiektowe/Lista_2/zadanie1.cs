//Cezary Milek; zadanie 1

using System;
using System.Text;

namespace kod
{
    public class IntStream //strumien liczb naturalnych
    {
        public int aktualna; //wartosc aktualnej liczby
        public IntStream() 
        {aktualna = 0;} //poczatek strumienia

        virtual public int Next() //kolejne lb. nat. od 0
        {
            if (Eos() == false) return ++aktualna;
            else {Console.WriteLine("Poza zakresem"); return aktualna;}
        }

        virtual public bool Eos() //koniec strumienia
        {
            if (Int32.MaxValue >= aktualna) return false; //poza zakresem
            else return true;
        }

        virtual public void Reset() //inicjacja nowego strumienia
        {aktualna = 0;}
    }

    public class PrimeStream : IntStream //strumien liczb pierwszych
    {   
        public PrimeStream()
        {aktualna = 1;} //poczatek strumienia

        private bool czy_pierwsza(int n)
        {
            for (int i = 2; i * i < n; i++)
                if (n % i == 0) return false;
            return true;
        }

        public override int Next() //nastepna liczba pierwsza
        {   
            if (Eos() == true) Console.WriteLine("Poza zakresem"); aktualna++;

            while (czy_pierwsza(aktualna) == false)
            {
                if (Eos() == true)
                {Console.WriteLine("Poza zakresem"); break;}
                else aktualna++;
            }
            return aktualna;
        }

        public override bool Eos() //koniec strumienia
        {
            if (Int32.MaxValue >= aktualna) return false;
            else return true;
        }

        public override void Reset() //inicjacja nowego strumienia
        {aktualna = 1;}
    }

    public class RandomStream : IntStream //strumien liczb losowych
    {
        private Random rand;
        public RandomStream()
        {rand = new Random(); // losowy obiekt o nazwie rand
        }

        public override int Next() //nastepna liczba
        {return rand.Next();}

        public override bool Eos() //koniec strumienia
        {return false;}
    }

    public class RandomWordStream //strumien napisow losowych
    {
        private PrimeStream primeStr;
        private RandomStream rand;

        public RandomWordStream()
        {   primeStr = new PrimeStream();
            rand = new RandomStream();
        }

        public string Next() //nastepny napis
        {
            int nastepna_pierwsza = primeStr.Next();
            StringBuilder napis = new StringBuilder(); // obiekt typu StringBuilder zamieniajacy na string, tu uzywamy System.Text

            for (int i = 0; i < nastepna_pierwsza; i++)
                napis.Append(rand_letter());

            return napis.ToString(); // zamiana na string
        }

        private char rand_letter() //losowy znak z alfabetu
        {   int losowanie = rand.Next() % 26;
            return (char)('a' + losowanie); 
        }
    }
     
    class Program // testy
    {
        static void Main(string[] args)
        {
            var primeStream = new PrimeStream();
            var randomStream = new RandomStream();
            var randomWordStream = new RandomWordStream();

            int liczba_losowych = 5;
            int liczba_pierwszych = 10;
            int liczba_napisow = 10;

            Console.WriteLine("RandomStream test:");
            for (int i = 0; i < liczba_losowych; i++) Console.WriteLine(randomStream.Next());

            Console.WriteLine("PrimeStream test:");
            for (int i = 0; i < liczba_pierwszych; i++) Console.WriteLine(primeStream.Next());

            Console.WriteLine("RandomWordStream test:");
            for (int i = 0; i < liczba_napisow; i++) Console.WriteLine(randomWordStream.Next());

        }
    }
}