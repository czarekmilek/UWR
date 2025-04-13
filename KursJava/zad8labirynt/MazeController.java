import javax.swing.*;
import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

public class MazeController {
    private final MazeModel mazeModel;
    private final MazeView mazeView;
    private final Timer ghostTimer;
    private final JFrame frame;

    public MazeController(MazeModel mazeModel, MazeView mazeView, JFrame frame) {
        this.mazeModel = mazeModel;
        this.mazeView = mazeView;
        this.frame = frame;

        this.ghostTimer = new Timer(2000, _ -> blockRandomPassage());

        addKeyBindings(mazeView);
    }

    public void startGame() {
        ghostTimer.stop();
        mazeModel.generateMaze();
        mazeModel.resetGame();
        ghostTimer.start();
        mazeView.refresh();
    }

    public void stopGame(boolean success) {
        ghostTimer.stop();
        String message = success ? "Gratulacje! Wygrałeś!" : "Gra zakończona porażką. Poddałeś się.";
        message += "\nCzas trwania: " + mazeModel.getElapsedTime() / 1000 + " sekund.";
        message += "\nLiczba ruchów: " + mazeModel.getMoveCount();
        JOptionPane.showMessageDialog(mazeView, message);
    }

    private boolean isKeyHeld = false;

    void moveTraveler(int dx, int dy) {
        if (isKeyHeld) return;
        isKeyHeld = true;

        boolean moved = mazeModel.moveTraveler(dx, dy);
        if (moved) {
            mazeView.refresh();

            if (mazeModel.isGameWon()) {
                stopGame(true);
            }
        }
        SwingUtilities.invokeLater(() -> isKeyHeld = false);
    }

    private void blockRandomPassage() {
        mazeModel.blockRandomWall();
        mazeView.refresh();
    }

    private void addKeyBindings(JPanel panel) {
        panel.addKeyListener(new KeyListener() {
            @Override
            public void keyPressed(KeyEvent e) {
                switch (e.getKeyCode()) {
                    case KeyEvent.VK_UP -> moveTraveler(0, -1);
                    case KeyEvent.VK_DOWN -> moveTraveler(0, 1);
                    case KeyEvent.VK_LEFT -> moveTraveler(-1, 0);
                    case KeyEvent.VK_RIGHT -> moveTraveler(1, 0);
                }
            }

            @Override
            public void keyTyped(KeyEvent e) {
            }

            @Override
            public void keyReleased(KeyEvent e) {
            }
        });

        panel.setFocusable(true);
        panel.requestFocusInWindow();
    }

    public void surrender() {
        stopGame(false);
    }

    public void setMazeWidth(int width) {
        if (width >= 5 && width <= 26) {
            mazeModel.setWidth(width);
            mazeView.setPreferredSize(new Dimension(
                    mazeModel.getWidth() * mazeView.getCellSize(),
                    mazeModel.getHeight() * mazeView.getCellSize()));
            mazeView.revalidate();
            frame.pack();
            this.startGame();
        } else {
            JOptionPane.showMessageDialog(null, "Szerokość musi być liczbą między 5 a 26.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public void setMazeHeight(int height) {
        if (height >= 5 && height <= 26) {
            mazeModel.setHeight(height);
            mazeView.setPreferredSize(new Dimension(
                    mazeModel.getWidth() * mazeView.getCellSize(),
                    mazeModel.getHeight() * mazeView.getCellSize()));
            mazeView.revalidate();
            frame.pack();
            this.startGame();
        } else {
            JOptionPane.showMessageDialog(null, "Wysokość musi być liczbą między 5 a 26.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
}
