import java.util.*;
import java.util.logging.*;
import java.io.*;

/**
 * Custom exception for invalid input errors in the game.
 */
class InvalidInputException extends Exception {
    public InvalidInputException(String message) {
        super(message);
    }
}

/**
 * Custom exception for out-of-bounds errors in the game.
 */
class OutOfBoundsException extends Exception {
    public OutOfBoundsException(String message) {
        super(message);
    }
}

/**
 * The Game class represents the logic for the permutation guessing game.
 * It manages the game state, including attempts, current permutation, and game history.
 */
public class Game {
    private List<Integer> currentPermutation;
    private int attemptsCount;
    private int N;
    private static Logger logger = Logger.getLogger(Game.class.getName());
    public boolean wonGame;

    /**
     * Constructor to initialize the game with a specified difficulty level.
     *
     * @param N the length of the permutation to guess
     */
    public Game(int N) {
        this.N = N;
        this.attemptsCount = 0;
        this.wonGame = false;
        generatePermutation();
        configureLogger();
        logger.info("Game started with N = " + N);
    }

    /**
     * Generates a random permutation of numbers from 1 to N.
     */
    private void generatePermutation() {
        List<Integer> numbers = new ArrayList<>();
        for (int i = 1; i <= N; i++) {
            numbers.add(i);
        }
        Collections.shuffle(numbers);
        this.currentPermutation = numbers;
    }

    /**
     * Configures the logger using properties from the specified logging properties file.
     */
    private void configureLogger() {
        try {
            LogManager.getLogManager().readConfiguration(new FileInputStream("logging.properties"));
        } catch (IOException e) {
            System.err.println("Could not setup logger configuration: " + e.toString());
        }
    }

    /**
     * Processes the player's guess and provides feedback.
     *
     * @param guessList the player's guessed permutation
     * @throws InvalidInputException if the guess is not valid
     * @throws OutOfBoundsException if the guess exceeds the allowed number of attempts
     */
    public void guess(List<Integer> guessList) throws InvalidInputException, OutOfBoundsException {
        if (guessList.size() != N || new HashSet<>(guessList).size() != N) {
            throw new InvalidInputException("Guess must contain " + N + " unique numbers from 1 to " + N + ".");
        }
        for (int num : guessList) {
            if (num < 1 || num > N) {
                throw new InvalidInputException("Each number must be between 1 and " + N + ".");
            }
        }

        attemptsCount++;
        assert attemptsCount <= N * N : "Exceeded maximum attempts.";

//        if (attemptsCount > N * N) {
//            logger.warning("Player has exceeded the maximum number of attempts.");
//            System.out.println("You lost! Resetting the game.");
//            resetGame();
////            throw new OutOfBoundsException("Exceeded maximum attempts.");
//        }

        String attemptRecord = "Attempt " + attemptsCount + ": " + guessList;
        System.out.println(attemptRecord);
        if (guessList.equals(currentPermutation)) {
            logger.info(attemptRecord + " - Correct guess!");
            wonGame = true;
            System.out.println("Congratulations! You've guessed the correct permutation!");

        } else {
            giveFeedback(guessList);
        }
    }

    /**
     * Provides feedback to the player about the current guess.
     *
     * @param guessList the player's guessed permutation
     */
    private void giveFeedback(List<Integer> guessList) {
        int misplacedCount = 0;
        for (int i = 0; i < N; i++) {
            if (!guessList.get(i).equals(currentPermutation.get(i))) {
                misplacedCount++;
            }
        }
        int randomIndex = new Random().nextInt(N);
        while (guessList.get(randomIndex).equals(currentPermutation.get(randomIndex))) {
            randomIndex = new Random().nextInt(N);
        }

        String direction;
        if (randomIndex == 0) {
            direction = "right";
        } else if (randomIndex == N - 1) {
            direction = "left";
        } else {
            direction = "left or right";
        }

        String feedback = "Incorrect guess. " + misplacedCount + " digits are misplaced.";
        String hint = "Hint: Digit " + guessList.get(randomIndex) + " should be moved to the " + direction + ".";
        logger.info("Player guessed: " + guessList + ", misplaced digits: " + misplacedCount);
        System.out.println(feedback);
        System.out.println(hint);
    }

    /**
     * Ends the game and logs the end event.
     */
    public void endGame() {
        logger.info("Game ended.");
        System.out.println("Game ended. Thanks for playing!");
    }

    /**
     * Resets the game and starts a new round.
     */
    public void resetGame() {
        this.attemptsCount = 0;
        generatePermutation();
        logger.info("Round ended.");
        logger.info("New round started with N = " + N);
        System.out.println("Starting a new round with N = " + N + "!");
    }
}
