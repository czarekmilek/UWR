package org.example.zad4tcp_2;

import java.io.*;
import java.net.*;
import java.util.Date;

public class DateServer {
    public static void main(String[] args) {
        int port = 20251;
        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("DateServer uruchomiony na porcie " + port);
            while (true) {
                Socket clientSocket = serverSocket.accept();
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true);
                // Wysyłamy aktualną datę i godzinę
                out.println(new Date().toString());
                clientSocket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
