import java.awt.*;
import java.awt.event.*;

public class DrawingApplication extends Frame implements KeyListener {
    private final Powierzchnia powierzchnia;

    public DrawingApplication() {
        Wrapper kreskiWrapper = new Wrapper(10);
        powierzchnia = new Powierzchnia(kreskiWrapper);

        setTitle("Drawing Application");
        setSize(1500, 800);
        setLayout(new BorderLayout());
        add(powierzchnia, BorderLayout.CENTER);

        Panel colorPanel = getColorPanel(powierzchnia);
        add(colorPanel, BorderLayout.EAST);

        powierzchnia.addKeyListener(this);
        powierzchnia.setFocusable(true);

        addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        setFocusable(true);
        requestFocusInWindow();
        setVisible(true);
    }

    private static Panel getColorPanel(Powierzchnia powierzchnia) {
        String[] colorNames = {"Black", "Red", "Blue", "Green",
                "Yellow", "Orange", "Cyan", "Magenta",
                "Pink", "Gray", "White"};
        Color[] colors = {Color.BLACK, Color.RED, Color.BLUE, Color.GREEN,
                Color.YELLOW, Color.ORANGE, Color.CYAN, Color.MAGENTA,
                Color.PINK, Color.GRAY, Color.WHITE};

        Panel colorPanel = new Panel();
        colorPanel.setLayout(new GridLayout(colorNames.length, 1));
        CheckboxGroup colorGroup = new CheckboxGroup();

        for (int i = 0; i < colorNames.length; i++) {
            Panel itemPanel = new Panel(new BorderLayout());
            Checkbox colorCheckbox = new Checkbox(colorNames[i], colorGroup, i == 0);
            colorCheckbox.setBackground(colors[i]);

            if (colors[i] == Color.BLACK || colors[i] == Color.BLUE) {
                colorCheckbox.setForeground(Color.WHITE);
            } else {
                colorCheckbox.setForeground(Color.BLACK);
            }

            colorCheckbox.setPreferredSize(new Dimension(60, 20));
            int index = i;
            colorCheckbox.addItemListener(_ -> {
                if (colorGroup.getSelectedCheckbox() == colorCheckbox) {
                    powierzchnia.setCurrentColor(colors[index]);
                }
            });

            Label colorFiller = new Label("");
            colorFiller.setBackground(colors[i]);
            colorFiller.setPreferredSize(new Dimension(4, 20));

            itemPanel.add(colorCheckbox, BorderLayout.EAST);
            itemPanel.add(colorFiller, BorderLayout.WEST);

            colorPanel.add(itemPanel);
        }
        return colorPanel;
    }

    @Override
    public void keyPressed(KeyEvent e) {
        switch (e.getKeyCode()) {
            case KeyEvent.VK_BACK_SPACE:
                powierzchnia.resetKreski();
                break;
            case KeyEvent.VK_F:
                powierzchnia.removeFirstKreska();
                break;
            case KeyEvent.VK_B:
            case KeyEvent.VK_L:
                powierzchnia.removeLastKreska();
                break;
        }
    }

    @Override
    public void keyTyped(KeyEvent e) {}

    @Override
    public void keyReleased(KeyEvent e) {}

    public static void main(String[] args) {
        new DrawingApplication();
    }
}
