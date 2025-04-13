package org.example.zad4tcp_2;

import java.io.*;
import java.net.*;

public class EchoServer {
    public static void main(String[] args) {
        int port = 20252;
        long startTime = System.currentTimeMillis();
        long duration = 60 * 1000;

        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("EchoServer uruchomiony na porcie " + port);
            while (System.currentTimeMillis() - startTime < duration) {
                Socket clientSocket = serverSocket.accept();
                // Obsługa klienta w osobnym wątku
                new Thread(() -> handleClient(clientSocket)).start();
            }
            System.out.println("Minął czas działania EchoServer. Kończenie pracy.");
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
                out.println(line);
                // Jeśli linia to pojedyncza kropka, kończymy dialog
                if (line.trim().equals(".")) {
                    break;
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
}
