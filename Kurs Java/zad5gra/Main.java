import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Logger;

/**
 * Main class to run the guessing game.
 */
public class Main {
    private static Logger logger = Logger.getLogger(Main.class.getName());

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean playing = true;
        System.out.println("Welcome to the guessing game!");

        while (playing) {
            System.out.print("Enter difficulty level (N from 3 to 9): ");
            int N = scanner.nextInt();
            while (N < 3 || N > 9) {
                System.out.print("Invalid input. Enter a value between 3 and 9: ");
                logger.warning("Invalid input on picking difficulty: " + N);
                N = scanner.nextInt();
            }
            scanner.nextLine();

            Game game = new Game(N);
            boolean roundActive = true;

            while (roundActive) {
                System.out.print("Enter your guess (space-separated " + N + " numbers, or -1 to end round): ");
                List<Integer> guess = new ArrayList<>();
                boolean endRound = false;

                try {
                    for (int i = 0; i < N; i++) {
                        int input = scanner.nextInt();
                        if (input == -1) {
                            endRound = true;
                            break;
                        }
                        if (input < 1 || input > N) {
                            logger.warning("Invalid number: " + input);
                            throw new InvalidInputException("Invalid number: " + input + ". Please enter numbers between 1 and " + N);
                        }
                        guess.add(input);
                    }
                    scanner.nextLine();

                    if (endRound) {
                        System.out.print("Do you want to quit the game? (yes/no/reset): ");
                        String response = scanner.nextLine();
                        if (response.equalsIgnoreCase("yes")) {
                            playing = false;
                            roundActive = false;
                            game.endGame();
                        } else if (response.equalsIgnoreCase("reset")) {
                            roundActive = false;
                        }
                        continue;
                    }

                    game.guess(guess);

                    if (game.wonGame) {
                        System.out.println("What do you want to do next? (quit/play): ");
                        String response = scanner.nextLine();
                        if (response.equalsIgnoreCase("quit")) {
                            playing = false;
                            roundActive = false;
                            game.endGame();
                        } else if (response.equalsIgnoreCase("play")) {
                            roundActive = false;
                        }
                    }

                } catch (InvalidInputException | OutOfBoundsException | InputMismatchException e) {
                    System.out.println(e.getMessage());
                    scanner.nextLine();
                    if (e instanceof OutOfBoundsException) {
                        playing = false;
                        roundActive = false;
                    }
                }
            }
        }
        scanner.close();
    }
}
