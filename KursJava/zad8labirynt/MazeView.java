import javax.swing.*;
import java.awt.*;

public class MazeView extends JPanel {
    private final MazeModel mazeModel;
    private final int cellSize = 50;
    private Image travelerImage;

    public MazeView(MazeModel mazeModel) {
        this.mazeModel = mazeModel;
        loadTravelerImage();
        setPreferredSize(new Dimension(
                mazeModel.getWidth() * cellSize,
                mazeModel.getHeight() * cellSize
        ));
    }

    private Color backgroundColor = Color.WHITE;
    private Color wallColor = Color.BLACK;

    public void setBackgroundColor(Color color) {
        if (color != null) {
            this.backgroundColor = color;
            repaint();
        }
    }

    public void setWallColor(Color color) {
        if (color != null) {
            this.wallColor = color;
            repaint();
        }
    }

    private void loadTravelerImage() {
        try {
            travelerImage = new ImageIcon("podroznik.png").getImage();
            travelerImage = travelerImage.getScaledInstance(cellSize, cellSize, Image.SCALE_SMOOTH);
        } catch (Exception e) {
            System.err.println("Nie znaleziono obrazu podróżnika.");
        }
    }
    private boolean showFieldLabels = false;

    public void toggleFieldLabels(boolean enabled) {
        this.showFieldLabels = enabled;
        repaint();
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);
        Graphics2D g2d = (Graphics2D) g;
        g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        for (int y = 0; y < mazeModel.getHeight(); y++) {
            for (int x = 0; x < mazeModel.getWidth(); x++) {
                drawCell(g2d, x, y);
            }
        }
        if (showFieldLabels) {
            drawFieldLabels(g2d);
        }
        drawTraveler(g2d);
    }

    private void drawFieldLabels(Graphics2D g2d) {
        g2d.setColor(Color.GRAY);
        g2d.setFont(new Font("Arial", Font.BOLD, 12));

        for (int y = 0; y < mazeModel.getHeight(); y++) {
            String label = String.valueOf((char) ('A' + y));
            g2d.drawString(label, 5, y * cellSize + cellSize / 2);
        }

        for (int x = 0; x < mazeModel.getWidth(); x++) {
            String label = String.valueOf(x + 1);
            g2d.drawString(label, x * cellSize + cellSize / 2, 15);
        }
    }


    private void drawCell(Graphics2D g2d, int x, int y) {
        int startX = x * cellSize;
        int startY = y * cellSize;

        if (x == 0 && y == 0) {
            g2d.setColor(Color.GREEN);
        } else if (x == mazeModel.getWidth() - 1 && y == mazeModel.getHeight() - 1) {
            g2d.setColor(Color.BLUE);
        } else {
            g2d.setColor(backgroundColor);
        }
        g2d.fillRect(startX, startY, cellSize, cellSize);

        g2d.setColor(wallColor);
        boolean[] walls = mazeModel.getWallsForCell(x, y);
        for (int i = 0; i < 4; i++) {
            if (walls[i]) {
                Point p = new Point(x, y);
                if (mazeModel.getBlockedWalls().containsKey(p)) {
                    long timeBlocked = mazeModel.getBlockedWalls().get(p);
                    if (System.currentTimeMillis() - timeBlocked < 3000) {
                        g2d.setColor(Color.RED);
                    }
                }
                drawWall(g2d, startX, startY, i);
                g2d.setColor(wallColor);
            }
        }
    }

    private void drawWall(Graphics2D g2d, int startX, int startY, int direction) {
        switch (direction) {
            case 0 -> g2d.drawLine(startX, startY, startX + cellSize, startY); // Top
            case 1 -> g2d.drawLine(startX + cellSize, startY, startX + cellSize, startY + cellSize); // Right
            case 2 -> g2d.drawLine(startX, startY + cellSize, startX + cellSize, startY + cellSize); // Bottom
            case 3 -> g2d.drawLine(startX, startY, startX, startY + cellSize); // Left
        }
    }


    private void drawTraveler(Graphics2D g2d) {
        int travelerX = mazeModel.getTravelerX();
        int travelerY = mazeModel.getTravelerY();

        int centerX = travelerX * cellSize + cellSize / 2;
        int centerY = travelerY * cellSize + cellSize / 2;

        if (travelerImage != null) {
            int imgSize = cellSize - 10;
            g2d.drawImage(travelerImage, centerX - imgSize / 2, centerY - imgSize / 2, imgSize, imgSize, this);
        } else {
            System.err.println("Nie znaleziono obrazu podróżnika.");
        }
    }

    public void refresh() {
        repaint();
    }

    public int getCellSize() {
        return cellSize;
    }
}
