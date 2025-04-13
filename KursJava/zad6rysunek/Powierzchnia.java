import java.awt.*;
import java.awt.event.*;

public class Powierzchnia extends Canvas {
    private final Wrapper kreskiWrapper;
    private Point startPoint;
    private Color currentColor = Color.BLACK;

    public Powierzchnia(Wrapper kreskiWrapper) {
        this.kreskiWrapper = kreskiWrapper;

        addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                startPoint = e.getPoint();
            }

            @Override
            public void mouseReleased(MouseEvent e) {
                if (startPoint != null) {
                    Point endPoint = e.getPoint();
                    boolean isInside = endPoint.x >= 0 && endPoint.y >= 0 && endPoint.x <= 1500 && endPoint.y <= 800;
                    if (isInside) {
                    if (kreskiWrapper.kreskiCount >= kreskiWrapper.kreski.length) {
                        Kreska[] newKreski = new Kreska[kreskiWrapper.kreski.length + 10];
                        System.arraycopy(kreskiWrapper.kreski, 0, newKreski, 0, kreskiWrapper.kreski.length);
                        kreskiWrapper.kreski = newKreski;
                    }
                    kreskiWrapper.kreski[kreskiWrapper.kreskiCount++] = new Kreska(startPoint, endPoint, currentColor);
                    startPoint = null;
                    repaint();
                    }
                }
            }
        });

        addMouseMotionListener(new MouseMotionAdapter() {
            @Override
            public void mouseDragged(MouseEvent e) {
                if (startPoint != null) {
                    Graphics g = getGraphics();
                    update(g);
                    g.setColor(Color.GRAY);
                    g.drawLine(startPoint.x, startPoint.y, e.getX(), e.getY());
                }
            }
        });
    }

    public void setCurrentColor(Color color) {
        this.currentColor = color;
    }

    @Override
    public void paint(Graphics g) {
        for (int i = 0; i < kreskiWrapper.kreskiCount; i++) {
            kreskiWrapper.kreski[i].draw(g);
        }
    }

    public void resetKreski() {
        kreskiWrapper.kreskiCount = 0;
        repaint();
    }

    public void removeFirstKreska() {
        if (kreskiWrapper.kreskiCount > 0) {
            System.arraycopy(kreskiWrapper.kreski, 1, kreskiWrapper.kreski, 0, kreskiWrapper.kreskiCount - 1);
            kreskiWrapper.kreskiCount--;
            repaint();
        }
    }

    public void removeLastKreska() {
        if (kreskiWrapper.kreskiCount > 0) {
            kreskiWrapper.kreskiCount--;
            repaint();
        }
    }
}
