package org.example.zad4tcp_2;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;

import java.io.*;
import java.net.Socket;

public class GuessNumberClient extends Application {
    private TextArea logArea;
    private TextField inputField;
    private TextField hostField;
    private Button connectButton;
    private Socket socket;
    private PrintWriter out;
    private BufferedReader in;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        hostField = new TextField("localhost");
        hostField.setPrefWidth(150);
        connectButton = new Button("Połącz");
        connectButton.setOnAction(e -> connectToServer());
        HBox connectionBox = new HBox(10, new Label("Host:"), hostField, connectButton);

        logArea = new TextArea();
        logArea.setEditable(false);

        inputField = new TextField();
        inputField.setPrefWidth(200);
        Button sendButton = new Button("Wyślij typ");
        sendButton.setOnAction(e -> sendGuess());
        Button surrenderButton = new Button("Poddaj się");
        surrenderButton.setOnAction(e -> surrender());
        HBox inputBox = new HBox(10, inputField, sendButton, surrenderButton);

        VBox root = new VBox(10, connectionBox, logArea, inputBox);
        root.setPadding(new Insets(10));
        Scene scene = new Scene(root, 600, 400);
        primaryStage.setTitle("GuessNumber Client");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    private void connectToServer() {
        try {
            socket = new Socket(hostField.getText(), 20254);
            out = new PrintWriter(socket.getOutputStream(), true);
            in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            log("Połączono z serwerem.");
            connectButton.setDisable(true);
            // Uruchamiamy wątek nasłuchujący wiadomości od serwera
            Thread listenerThread = new Thread(() -> listenToServer());
            listenerThread.setDaemon(true);
            listenerThread.start();
        } catch (IOException e) {
            log("Błąd połączenia: " + e.getMessage());
        }
    }

    private void listenToServer() {
        try {
            String line;
            while ((line = in.readLine()) != null) {
                log("Serwer: " + line);
            }
        } catch (IOException e) {
            log("Połączenie zamknięte.");
        }
    }

    private void sendGuess() {
        if (socket == null || socket.isClosed()) {
            log("Brak połączenia z serwerem.");
            return;
        }
        String guess = inputField.getText().trim();
        if (!guess.isEmpty()) {
            out.println(guess);
            log("Wysłano: " + guess);
            inputField.clear();
        }
    }

    private void surrender() {
        if (socket != null && !socket.isClosed()) {
            out.println("Poddaję się");
            try {
                socket.close();
            } catch (IOException e) {
                log("Błąd przy zamykaniu połączenia: " + e.getMessage());
            }
            log("Poddano się. Połączenie zamknięte.");
        }
    }

    private void log(String message) {
        Platform.runLater(() -> logArea.appendText(message + "\n"));
    }
}
