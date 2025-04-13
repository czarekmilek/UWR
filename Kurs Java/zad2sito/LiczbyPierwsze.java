import java.util.ArrayList;
import java.util.List;

public final class LiczbyPierwsze {
    private final static int POTEGA2 = 21;
    private final static int ROZMIAR_SITO = 1 << POTEGA2; // 2^21
    private final static int[] SITO = new int[ROZMIAR_SITO];

    static {
        for (int i = 2; i < ROZMIAR_SITO; i++) {
            if (SITO[i] == 0) {
                for (int j = i; j < ROZMIAR_SITO; j += i) {
                    if (SITO[j] == 0) {
                        SITO[j] = i;
                    }
                }
            }
        }
    }

    public static boolean czyPierwsza(long n) {
        if (n < 2) return false;
        if (n < ROZMIAR_SITO) {
            return SITO[(int) n] == n;
        }

        for (int i = 2; i < ROZMIAR_SITO && (long) i * i <= n; i++) {
            if (SITO[i] == i) {
                if (n % i == 0) {
                    return false;
                }
            }
        }

        return true;
    }


    public static long[] naCzynnikiPierwsze(long n) {
        if (n == 0) return new long[] { 0 };
        if (n == 1 || n == -1) return new long[] { n };
        if (n == Long.MIN_VALUE) return new long[] { -1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 };

        long n_max = n;
        List<Long> czynniki = new ArrayList<>();
        if (n < 0) {
            czynniki.add(-1L);
            n = -n;
        }

        while (n >= 2 && n < ROZMIAR_SITO) {
            long czynnik = SITO[(int) n];
            czynniki.add(czynnik);
            n /= czynnik;
        }

        long i = 2;
        while (i < ROZMIAR_SITO && i * i <= n_max) {
            if (SITO[(int) i] == i) {
                while (n % i == 0) {
                    czynniki.add(i);
                    n /= i;
                }
            }
            i++;
        }

        for (long j = i; j * j <= n_max; j++) {
            while (n % j == 0) {
                czynniki.add(j);
                n /= j;
            }
        }

        if (n > 1) {
            czynniki.add(n);
        }

        long[] wynik = new long[czynniki.size()];
        for (int k = 0; k < czynniki.size(); k++) {
            wynik[k] = czynniki.get(k);
        }

        return wynik;
    }

    public static void main(String[] args) {
        if (args.length == 0) {
            System.err.println("Nie podano argumentów liczbowych");
            return;
        }

        for (String arg : args) {
            try {
                long liczba = Long.parseLong(arg);
                if (!czyPierwsza(liczba)) {
                    long[] czynniki = naCzynnikiPierwsze(liczba);
                    System.out.print(liczba + " = ");
                    for (int i = 0; i < czynniki.length; i++) {
                        if (i > 0) System.out.print(" * ");
                        System.out.print(czynniki[i]);
                    }
                    System.out.println();
                } else {
                    System.out.println(liczba + " = " + liczba);
                }
            } catch (NumberFormatException e) {
                System.err.println("Błędny format liczby: " + arg);
            }
        }
    }
}
