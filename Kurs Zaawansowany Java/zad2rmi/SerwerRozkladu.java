import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

public class SerwerRozkladu {
    public static void main(String[] args) {
        try {
            // Próba uruchomienia rejestru na porcie 1099
            try {
                LocateRegistry.createRegistry(1099);
                System.out.println("RMI registry zostal uruchomiony.");
            } catch (Exception e) {
                System.out.println("RMI registry już dziala.");
            }

            Rozklad rozklad = new RozkladImpl();
            Naming.rebind("rmi://localhost/Rozklad", rozklad);
            System.out.println("Obiekt Rozklad zostal zarejestrowany i jest gotowy do pracy.");
        } catch (Exception e) {
            System.err.println("Wyjątek: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
