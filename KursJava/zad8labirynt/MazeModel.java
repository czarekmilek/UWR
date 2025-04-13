import java.awt.*;
import java.util.*;
import java.util.List;

public class MazeModel {
    private int width;
    private int height;
    private Cell[][] grid;

    private int travelerX = 0;
    private int travelerY = 0;
    private long startTime;
    private int moveCount;

    public MazeModel(int width, int height) {
        if (width < 5 || height < 5 || width > 26 || height > 26) {
            throw new IllegalArgumentException("Labirynt musi mieć rozmiar między 5x5 a 26x26.");
        }
        this.width = width;
        this.height = height;
        this.grid = new Cell[height][width];
        generateMaze();
        resetGame();
    }

    private static class Cell {
        boolean visited = false;
        boolean[] walls = {true, true, true, true}; // Top, Right, Bottom, Left

        public void removeWall(int direction) {
            walls[direction] = false;
        }
    }

    private final Map<Point, Long> blockedWalls = new HashMap<>();

    public void blockRandomWall() {
        Random rand = new Random();
        int x = rand.nextInt(width);
        int y = rand.nextInt(height);
        int direction = rand.nextInt(4);

        if (!grid[y][x].walls[direction]) {
            grid[y][x].walls[direction] = true;
            blockedWalls.put(new Point(x, y), System.currentTimeMillis());
        }
//        System.out.println("Blokowanie w komórce: (" + x + ", " + y + ") w czasie: " + System.currentTimeMillis());
    }

    public Map<Point, Long> getBlockedWalls() {
        return blockedWalls;
    }

    void generateMaze() {
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                grid[y][x] = new Cell();
            }
        }
        generateMazeDFS(0, 0);
    }

    private void generateMazeDFS(int x, int y) {
        grid[y][x].visited = true;
        List<Integer> directions = new ArrayList<>(List.of(0, 1, 2, 3)); // Top, Right, Bottom, Left
        Collections.shuffle(directions);

        for (int direction : directions) {
            int nx = x, ny = y;
            switch (direction) {
                case 0 -> ny--; // Top
                case 1 -> nx++; // Right
                case 2 -> ny++; // Bottom
                case 3 -> nx--; // Left
            }

            if (isValidCell(nx, ny) && !grid[ny][nx].visited) {
                grid[y][x].removeWall(direction);
                grid[ny][nx].removeWall((direction + 2) % 4);
                generateMazeDFS(nx, ny);
            }
        }
    }

    private boolean isValidCell(int x, int y) {
        return x >= 0 && x < width && y >= 0 && y < height;
    }

    public boolean moveTraveler(int dx, int dy) {
        int newX = travelerX + dx;
        int newY = travelerY + dy;

        if (isValidCell(newX, newY) && !hasWall(travelerX, travelerY, dx, dy)) {
            travelerX = newX;
            travelerY = newY;
            moveCount++;
            return true;
        }
        return false;
    }

    private boolean hasWall(int x, int y, int dx, int dy) {
        int direction = switch (dx) {
            case 1 -> 1; // Right
            case -1 -> 3; // Left
            default -> (dy == 1 ? 2 : 0); // Bottom / Top
        };
        return grid[y][x].walls[direction] || blockedWalls.containsKey(new Point(x, y));
    }

    public void resetGame() {
        travelerX = 0;
        travelerY = 0;
        moveCount = 0;
        startTime = System.currentTimeMillis();
        blockedWalls.clear();
    }

    public boolean isGameWon() {
        return travelerX == width - 1 && travelerY == height - 1;
    }

    public long getElapsedTime() {
        return System.currentTimeMillis() - startTime;
    }

    public int getMoveCount() {
        return moveCount;
    }

    public int getTravelerX() {
        return travelerX;
    }

    public int getTravelerY() {
        return travelerY;
    }

    public int getWidth() {
        return width;
    }

    public int getHeight() {
        return height;
    }

    public boolean[] getWallsForCell(int x, int y) {
        if (x < 0 || x >= width || y < 0 || y >= height) {
            throw new IllegalArgumentException("Nieprawidłowa lokalizacja komórki.");
        }
        return grid[y][x].walls;
    }

    public void setWidth(int width) {
        if (width >= 5 && width <= 26) {
            this.width = width;
            this.grid = new Cell[height][width];
            generateMaze();
        } else {
            throw new IllegalArgumentException("Szerokość musi być liczbą między 5 a 26.");
        }
    }

    public void setHeight(int height) {
        if (height >= 5 && height <= 26) {
            this.height = height;
            this.grid = new Cell[height][width];
            generateMaze();
        } else {
            throw new IllegalArgumentException("Wysokość musi być liczbą między 5 a 26.");
        }
    }
}
