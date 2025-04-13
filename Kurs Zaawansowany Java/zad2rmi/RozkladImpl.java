import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.LinkedList;

public class RozkladImpl extends UnicastRemoteObject implements Rozklad {

    protected RozkladImpl() throws RemoteException {
        super();
    }

    @Override
    public LinkedList<Long> naCzynnikiPierwsze(long x) throws RemoteException {
        LinkedList<Long> factors = new LinkedList<>();

        // Rozkład liczb -1, 0, 1
        if (x == -1 || x == 0 || x == 1) {
            factors.add(x);
            return factors;
        }

        if (x < 0) {
            factors.add(-1L);
            if (x == Long.MIN_VALUE) {
                System.out.println(Long.MIN_VALUE);
                // Long.MIN_VALUE = -2^63, więc dzielimy przez 2 aż osiągniemy -1
                long n = x;
                while (n != -1) {
                    factors.add(2L);
                    n /= 2;
                }
                return factors;
            } else {
                x = -x;
            }
        }

        long n = x;

        // Najpierw dzielimy przez 2 (jeśli i dopóki można)
        while (n % 2 == 0) {
            factors.add(2L);
            n /= 2;
        }
        // Następnie sprawdzamy dzielniki nieparzyste od 3 do sqrt(n)
        for (long i = 3; i <= Math.sqrt(n); i += 2) {
            while (n % i == 0) {
                factors.add(i);
                n /= i;
            }
        }
        // Jeśli pozostała liczba jest większa od 1, jest czynnikiem pierwszym
        if (n > 1) {
            factors.add(n);
        }
        return factors;
    }
}
