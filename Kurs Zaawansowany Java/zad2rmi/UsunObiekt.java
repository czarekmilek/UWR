import java.rmi.Naming;

public class UsunObiekt {
    public static void main(String[] args) {
        try {
            Naming.unbind("rmi://localhost/Rozklad");
            System.out.println("Obiekt Rozkład został usunięty z rejestru.");
        } catch (Exception e) {
            System.err.println("Wyjątek przy usuwaniu obiektu: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
