package aquarium;

import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

public class Rybka implements PropertyChangeListener {
    private final String id;
    private final int minTemp;
    private final int maxTemp;

    public Rybka(String id, int minTemp, int maxTemp) {
        this.id = id;
        this.minTemp = minTemp;
        this.maxTemp = maxTemp;
    }

    @Override
    public void propertyChange(PropertyChangeEvent evt) {
        if ("temperature".equals(evt.getPropertyName())) {
            int newTemp = (int) evt.getNewValue();
            if (newTemp < minTemp || newTemp > maxTemp) {
                System.out.printf("Rybka %s umarła! Temperatura %d°C poza zakresem %d-%d°C%n",
                        id, newTemp, minTemp, maxTemp);
                ((Grzalka) evt.getSource()).removePropertyChangeListener(this);
            }
        }
    }
}