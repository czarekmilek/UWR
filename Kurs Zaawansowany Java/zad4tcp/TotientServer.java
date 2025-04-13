package org.example.zad4tcp_2;

import java.io.*;
import java.net.*;

public class TotientServer {
    // Flaga sterująca działaniem serwera
    private static volatile boolean running = true;

    public static void main(String[] args) {
        int port = 20253;

        // Wątek do odczytu poleceń operatora
        new Thread(() -> {
            BufferedReader consoleReader = new BufferedReader(new InputStreamReader(System.in));
            while (running) {
                try {
                    String command = consoleReader.readLine();
                    if (command != null && command.equalsIgnoreCase("quit")) {
                        running = false;
                        break;
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }).start();

        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("TotientServer uruchomiony na porcie " + port);
            serverSocket.setSoTimeout(1000);
            while (running) {
                try {
                    Socket clientSocket = serverSocket.accept();
                    new Thread(() -> handleClient(clientSocket)).start();
                } catch (SocketTimeoutException e) {
                    // Timeout - iterujemy dalej, sprawdzając running
                }
            }
            System.out.println("Polecenie quit. Kończenie pracy TotientServer.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void handleClient(Socket clientSocket) {
        try (
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true)
        ) {
            String line;
            while ((line = in.readLine()) != null) {
                if (line.trim().equals("quit")) {
                    break;
                }
                try {
                    int n = Integer.parseInt(line.trim());
                    if (n <= 0) {
                        out.println("Błąd: liczba musi być większa od 0.");
                        continue;
                    }
                    // Wyznaczamy ciąg liczb od 1 do n, które są względnie pierwsze z n
                    StringBuilder sb = new StringBuilder();
                    for (int i = 1; i <= n; i++) {
                        if (gcd(i, n) == 1) {
                            sb.append(i).append(" ");
                        }
                    }
                    out.println(sb.toString().trim());
                } catch (NumberFormatException ex) {
                    out.println("Błąd: niepoprawna liczba naturalna.");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                clientSocket.close();
            } catch (IOException e) {
            }
        }
    }

    // Metoda obliczająca największy wspólny dzielnik
    private static int gcd(int a, int b) {
        return (b == 0) ? a : gcd(b, a % b);
    }
}
