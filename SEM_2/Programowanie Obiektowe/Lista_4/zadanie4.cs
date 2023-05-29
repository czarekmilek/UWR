using System;
using System.Collections.Generic;

//nieterminale
class NonTerminal {
    public string Symbol { get; set; }
    
    public NonTerminal(string symbol) {
        Symbol = symbol;
    }
}

//terminale
class Terminal {
    public string Symbol { get; set; }
    
    public Terminal(string symbol) {
        Symbol = symbol;
    }
}

//produkty
class Production {
    public NonTerminal LHS { get; set; } //lewa strona produkcji
    public List<object> RHS { get; set; } //prawa strona produkcji

    public Production(NonTerminal lhs, List<object> rhs) {
        LHS = lhs;
        RHS = rhs;
    }
}

//gramatyka
class Grammar {
    public List<Production> Productions { get; set; }
    public NonTerminal StartSymbol { get; set; }

    public Grammar(List<Production> productions, NonTerminal startSymbol) {
        // przypisanie wartości argumentów do pól obiektu klasy Grammar
        Productions = productions;
        StartSymbol = startSymbol;
    }

    // metoda generująca losowe słowa na podstawie gramatyki
    public List<string> GenerateRandomWords(int count) {
        List<string> words = new List<string>();

        Random random = new Random();

        for (int i = 0; i < count; i++) {
            string word = ""; //generowane slowo

            Stack<object> stack = new Stack<object>(); //stos symboli gramatyki
            stack.Push(StartSymbol);

            //przetwarzanie symboli ze stosu
            while (stack.Count > 0) { 
                object symbol = stack.Pop();

                if (symbol is NonTerminal) {
                    NonTerminal nonTerminal = (NonTerminal)symbol; //przeksztalcenie symbolu na NonTerminal
                    List<Production> productions = Productions.FindAll(p => p.LHS.Symbol == nonTerminal.Symbol);

                    Production production = productions[random.Next(0, productions.Count)]; //losowa produkcja
                    production.RHS.Reverse(); 

                    foreach (object symbolInRHS in production.RHS) {
                        stack.Push(symbolInRHS);
                    }
                } else if (symbol is Terminal) {
                    Terminal terminal = (Terminal)symbol; //przeksztalcenie symbolu na Terminal
                    word = terminal.Symbol + word; //dodanie do slowa
                }
            }

            words.Add(word);
        }

        return words; //wynik
    }
}

class Program {
    static void Main(string[] args) {
        NonTerminal S = new NonTerminal("S");
        NonTerminal A = new NonTerminal("A");
        NonTerminal B = new NonTerminal("B");

        Terminal a = new Terminal("a");
        Terminal b = new Terminal("b");
        Terminal c = new Terminal("c");

        List<Production> productions = new List<Production>();
        productions.Add(new Production(S, new List<object>() { A, B }));
        productions.Add(new Production(A, new List<object>() { a, A }));
        productions.Add(new Production(A, new List<object>() { }));
        productions.Add(new Production(B, new List<object>() { b, B }));
        productions.Add(new Production(B, new List<object>() { c }));

        Grammar grammar = new Grammar(productions, S);

        List<string> words = grammar.GenerateRandomWords(13);

        foreach (string word in words) {
            Console.WriteLine(word);
        }

        Console.ReadLine();
    }
}
