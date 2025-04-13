import java.rmi.Naming;
import java.util.LinkedList;
import java.util.Scanner;

public class KlientRozkladu {
    public static void main(String[] args) {
        try {
            Rozklad rozklad = (Rozklad) Naming.lookup("rmi://localhost/Rozklad");
            Scanner scanner = new Scanner(System.in);

            while (true) {
                System.out.println("Podaj liczbę całkowitą (long) do rozkładu na czynniki pierwsze (lub 'q' aby zakończyć):");
                String input = scanner.next().trim();

                if (input.equalsIgnoreCase("q")) {
                    System.out.println("Koniec programu.");
                    break;
                }

                try {
                    long liczba = Long.parseLong(input);
                    LinkedList<Long> czynniki = rozklad.naCzynnikiPierwsze(liczba);

                    if (czynniki.size() == 1 && (liczba == -1 || liczba == 0 || liczba == 1)) {
                        System.out.println("Rozkład: " + czynniki.getFirst());
                    } else {
                        StringBuilder wynik = new StringBuilder();
                        for (Long factor : czynniki) {
                            wynik.append(factor).append(" * ");
                        }

                        // Usuwamy ostatni " * "
                        if (wynik.length() > 3) {
                            wynik.setLength(wynik.length() - 3);
                        }
                        System.out.println("Rozkład: " + wynik);
                    }
                } catch (NumberFormatException e) {
                    System.out.println("Nieprawidłowy format liczby. Spróbuj ponownie.");
                }
            }

            scanner.close();
        } catch (Exception e) {
            System.err.println("Wyjątek: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
