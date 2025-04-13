import javax.swing.*;
import java.awt.*;

public class MazeApplication {
    private JFrame frame;
    private MazeModel mazeModel;
    private MazeView mazeView;
    private MazeController mazeController;

    public MazeApplication() {
        initialize();
    }

    private void initialize() {
        frame = new JFrame("Labirynt");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(new BorderLayout());
        frame.setResizable(false);

        mazeModel = new MazeModel(10, 10); // Rozmiar domyślny
        mazeView = new MazeView(mazeModel);
        mazeController = new MazeController(mazeModel, mazeView, frame);

        mazeController.startGame();

        frame.setJMenuBar(createMenuBar());

        frame.add(mazeView, BorderLayout.CENTER);
        frame.add(createStatusPanel(), BorderLayout.SOUTH);

        frame.pack();
        frame.setLocationRelativeTo(null);
    }


    private JMenuBar createMenuBar() {
        JMenuBar menuBar = new JMenuBar();

        // Menu "Gra"
        JMenu gameMenu = new JMenu("Gra");
        JMenuItem startItem = new JMenuItem("Start");
        startItem.setMnemonic('S');
        startItem.setAccelerator(KeyStroke.getKeyStroke("control S"));
        startItem.addActionListener(_ -> mazeController.startGame());

        JMenuItem surrenderItem = new JMenuItem("Rezygnacja");
        surrenderItem.setMnemonic('R');
        surrenderItem.setAccelerator(KeyStroke.getKeyStroke("control R"));
        surrenderItem.addActionListener(_ -> mazeController.surrender());

        JMenuItem exitItem = new JMenuItem("Koniec");
        exitItem.setMnemonic('K');
        exitItem.setAccelerator(KeyStroke.getKeyStroke("control K"));
        exitItem.addActionListener(_ -> System.exit(0));

        gameMenu.add(startItem);
        gameMenu.add(surrenderItem);
        gameMenu.addSeparator();
        gameMenu.add(exitItem);

        // Menu "Ustawienia"
        JMenu settingsMenu = getSettingsMenu();

        // Menu "Ruchy"
        JMenu movesMenu = new JMenu("Ruchy");
        JMenuItem moveUpItem = new JMenuItem("W górę");
        moveUpItem.setAccelerator(KeyStroke.getKeyStroke("UP"));
        moveUpItem.addActionListener(_ -> mazeController.moveTraveler(0, -1));

        JMenuItem moveRightItem = new JMenuItem("W prawo");
        moveRightItem.setAccelerator(KeyStroke.getKeyStroke("RIGHT"));
        moveRightItem.addActionListener(_ -> mazeController.moveTraveler(1, 0));

        JMenuItem moveDownItem = new JMenuItem("W dół");
        moveDownItem.setAccelerator(KeyStroke.getKeyStroke("DOWN"));
        moveDownItem.addActionListener(_ -> mazeController.moveTraveler(0, 1));

        JMenuItem moveLeftItem = new JMenuItem("W lewo");
        moveLeftItem.setAccelerator(KeyStroke.getKeyStroke("LEFT"));
        moveLeftItem.addActionListener(_ -> mazeController.moveTraveler(-1, 0));

        movesMenu.add(moveUpItem);
        movesMenu.add(moveRightItem);
        movesMenu.add(moveDownItem);
        movesMenu.add(moveLeftItem);

        menuBar.add(gameMenu);
        menuBar.add(settingsMenu);
        menuBar.add(movesMenu);
        menuBar.add(Box.createHorizontalGlue());
        menuBar.add(createHelpMenu());

        return menuBar;
    }

    private JMenu getSettingsMenu() {
        JMenu settingsMenu = new JMenu("Ustawienia");

        JCheckBoxMenuItem markFieldsItem = new JCheckBoxMenuItem("Oznaczenie pól");
        markFieldsItem.addActionListener(_ -> mazeView.toggleFieldLabels(markFieldsItem.isSelected()));

        JMenu colorSubmenu = getColorSubmenu();
        JMenu sizeSubmenu = getSizeSubmenu();

        settingsMenu.add(markFieldsItem);
        settingsMenu.add(colorSubmenu);
        settingsMenu.add(sizeSubmenu);
        return settingsMenu;
    }

    private JMenu getSizeSubmenu() {
        JMenu sizeSubmenu = new JMenu("Rozmiary");
        JMenuItem setWidthItem = new JMenuItem("Szerokość");
        setWidthItem.addActionListener(_ -> mazeController.setMazeWidth(Integer.parseInt(JOptionPane.showInputDialog("Podaj szerokość (5-26):"))));

        JMenuItem setHeightItem = new JMenuItem("Wysokość");
        setHeightItem.addActionListener(_ -> mazeController.setMazeHeight(Integer.parseInt(JOptionPane.showInputDialog("Podaj wysokość (5-26):"))));

        sizeSubmenu.add(setWidthItem);
        sizeSubmenu.add(setHeightItem);
        return sizeSubmenu;
    }

    private JMenu getColorSubmenu() {
        JMenu colorSubmenu = new JMenu("Kolory");
        JMenuItem backgroundColorItem = new JMenuItem("Tło");
        backgroundColorItem.addActionListener(_ -> mazeView.setBackgroundColor(
                JColorChooser.showDialog(frame, "Wybierz kolor tła", Color.WHITE)));

        JMenuItem wallColorItem = new JMenuItem("Ściany");
        wallColorItem.addActionListener(_ -> mazeView.setWallColor(
                JColorChooser.showDialog(frame, "Wybierz kolor ścian", Color.BLACK)));

        colorSubmenu.add(backgroundColorItem);
        colorSubmenu.add(wallColorItem);
        return colorSubmenu;
    }

    private JMenu createHelpMenu() {
        JMenu helpMenu = new JMenu("Pomoc");
        JMenuItem aboutAppItem = new JMenuItem("O aplikacji");
        aboutAppItem.addActionListener(_ -> showInfoDialog("O aplikacji", "Zasady gry:" +
                "\nCelem jest doprowadzenie podróżnika do wyjścia z labiryntu." +
                "\nW dotarciu do celu przeszkadza duch, który blokuje nam drogę stawiając ściany na naszej trasie." +
                "\nGra kończy się wygraną, gdy gracz zajmie miejsce w komórce wyjściowej."));

        JMenuItem aboutAuthorItem = new JMenuItem("O autorze");
        aboutAuthorItem.addActionListener(_ -> showInfoDialog("O autorze", "Twórca: Cezary Miłek."));

        helpMenu.add(aboutAppItem);
        helpMenu.add(aboutAuthorItem);
        return helpMenu;
    }

    private JPanel createStatusPanel() {
        JPanel statusPanel = new JPanel();
        statusPanel.setLayout(new FlowLayout(FlowLayout.LEFT));

        JLabel statusLabel = new JLabel("Stan: Oczekiwanie na rozpoczęcie gry");
        statusPanel.add(statusLabel);

        Timer statusUpdater = new Timer(500, _ -> {
            if (mazeModel.isGameWon()) {
                statusLabel.setText("Stan: Wygrana!");
            } else {
                statusLabel.setText("Stan: Gra w toku. Ruchy: " + mazeModel.getMoveCount());
            }
        });
        statusUpdater.start();

        return statusPanel;
    }

    private void showInfoDialog(String title, String message) {
        JOptionPane.showMessageDialog(frame, message, title, JOptionPane.INFORMATION_MESSAGE);
    }

    public void run() {
        frame.setVisible(true);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            MazeApplication app = new MazeApplication();
            app.run();
        });
    }
}
