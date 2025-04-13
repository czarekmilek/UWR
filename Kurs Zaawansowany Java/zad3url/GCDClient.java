import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

public class GCDClient {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String continueChoice = "T";

        while (continueChoice.equalsIgnoreCase("T")) {
            System.out.print("Podaj pierwszą liczbę: ");
            String a = scanner.next();
            System.out.print("Podaj drugą liczbę: ");
            String b = scanner.next();

            try {
                URL url = new URL("http://localhost:8080/gcd");
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();

                conn.setRequestMethod("POST");
                conn.setDoOutput(true);

                // Przygotowanie danych POST
                String postData = "a=" + URLEncoder.encode(a, StandardCharsets.UTF_8) +
                        "&b=" + URLEncoder.encode(b, StandardCharsets.UTF_8);

                // Wysyłanie danych do serwera
                try (OutputStream os = conn.getOutputStream()) {
                    os.write(postData.getBytes());
                    os.flush();
                }

                // Pobranie odpowiedzi
                int responseCode = conn.getResponseCode();
                InputStream is;
                if (responseCode == 400) {
                    System.out.print("Błąd. ");
                    is = conn.getErrorStream();
                } else {
                    is = conn.getInputStream();
                }

                // Odczyt odpowiedzi serwera
                try (BufferedReader in = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                    String inputLine;
                    System.out.println("Odpowiedź serwera:");
                    while ((inputLine = in.readLine()) != null) {
                        System.out.println(inputLine);
                    }
                }
            } catch (IOException e) {
                System.out.println("Błąd połączenia: " + e.getMessage());
            }

            System.out.print("Czy chcesz kontynuować? (T/N): ");
            continueChoice = scanner.next();
        }

        System.out.println("Koniec programu.");
    }
}
