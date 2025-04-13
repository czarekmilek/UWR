package org.example.zad4tcp_2;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;

import java.io.*;
import java.net.*;
import java.util.Random;

public class PickNumberServer extends Application {
    private TextArea logArea;
    private ServerSocket serverSocket;
    private volatile boolean running = false;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        logArea = new TextArea();
        logArea.setEditable(false);
        Button startButton = new Button("Uruchom serwer");
        Button stopButton = new Button("Zatrzymaj serwer");
        stopButton.setDisable(true);

        startButton.setOnAction(e -> {
            startServer();
            startButton.setDisable(true);
            stopButton.setDisable(false);
        });

        stopButton.setOnAction(e -> {
            stopServer();
            startButton.setDisable(false);
            stopButton.setDisable(true);
        });

        VBox root = new VBox(10, new HBox(10, startButton, stopButton), logArea);
        Scene scene = new Scene(root, 600, 400);
        primaryStage.setTitle("PickNumber Server");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    private void startServer() {
        running = true;
        Thread serverThread = new Thread(() -> {
            try {
                serverSocket = new ServerSocket(20254);
                log("Serwer uruchomiony na porcie 20254. Oczekiwanie na klienta...");
                while (running) {
                    Socket client = serverSocket.accept();
                    log("Klient połączony: " + client.getInetAddress());
                    handleClient(client);
                }
            } catch (IOException e) {
                if (running) {
                    log("Błąd serwera: " + e.getMessage());
                }
            } finally {
                stopServer();
            }
        });
        serverThread.setDaemon(true);
        serverThread.start();
    }

    private void handleClient(Socket client) {
        new Thread(() -> {
            try (
                    BufferedReader in = new BufferedReader(new InputStreamReader(client.getInputStream()));
                    PrintWriter out = new PrintWriter(client.getOutputStream(), true)
            ) {
                Random rand = new Random();
                int target = 1000 + rand.nextInt(9000); // liczba z przedziału 1000-9999
                int attempts = 0;
                log("Wylosowano liczbę do odgadnięcia.");
                boolean gameEnded = false;
                while (!gameEnded) {
                    String line = in.readLine();
                    if (line == null) break;
                    attempts++;
                    int guess;
                    try {
                        guess = Integer.parseInt(line.trim());
                    } catch (NumberFormatException e) {
                        out.println("Błąd: wpisz poprawną liczbę.");
                        continue;
                    }
                    if (attempts > 12) {
                        out.println("Przegrana: przekroczono limit prób.");
                        log("Klient przekroczył limit prób. Koniec gry.");
                        gameEnded = true;
                    } else {
                        if (guess == target) {
                            out.println("równa");
                            out.println("Wygrałeś!");
                            log("Klient odgadł liczbę w " + attempts + " próbach.");
                            gameEnded = true;
                        } else if (guess < target) {
                            out.println("większa");
                        } else {
                            out.println("mniejsza");
                        }
                    }
                }
            } catch (IOException e) {
                log("Błąd połączenia z klientem: " + e.getMessage());
            } finally {
                try {
                    client.close();
                } catch (IOException e) {
                }
                log("Klient rozłączony.");
            }
        }).start();
    }

    private void stopServer() {
        running = false;
        try {
            if (serverSocket != null && !serverSocket.isClosed()) {
                serverSocket.close();
            }
        } catch (IOException e) {
            log("Błąd przy zamykaniu serwera: " + e.getMessage());
        }
        log("Serwer zatrzymany.");
    }

    private void log(String message) {
        Platform.runLater(() -> logArea.appendText(message + "\n"));
    }
}
