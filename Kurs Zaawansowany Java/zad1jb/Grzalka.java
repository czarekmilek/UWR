package aquarium;

import java.beans.PropertyChangeSupport;
import java.beans.PropertyChangeListener;
import java.io.Serializable;

public class Grzalka implements Serializable {
    private int temperature = 20;
    private final PropertyChangeSupport pcs = new PropertyChangeSupport(this);
    private Thermostat thermostat;

    public Grzalka() {}

    public void setTemperature(int newTemp) {
        int oldTemp = this.temperature;
        if (newTemp < 10 || newTemp > 40) {
            System.out.println("Grzałka: Próba ustawienia poza zakresem 10-40°C: " + newTemp);
            return;
        }
        if (thermostat != null && !thermostat.isChangeAllowed(newTemp)) {
            System.out.println("Termostat: Blokada zmiany na " + newTemp + "°C");
            return;
        }
        this.temperature = newTemp;
        pcs.firePropertyChange("temperature", oldTemp, newTemp);
        System.out.println("Grzałka: Zmiana z " + oldTemp + "°C na " + newTemp + "°C");
    }

    public synchronized void increaseTemp() {
        setTemperature(temperature + 1);
    }

    public synchronized void decreaseTemp() {
        setTemperature(temperature - 1);
    }

    public void setThermostat(Thermostat thermostat) {
        this.thermostat = thermostat;
    }

    public void addPropertyChangeListener(PropertyChangeListener listener) {
        pcs.addPropertyChangeListener(listener);
    }

    public void removePropertyChangeListener(PropertyChangeListener listener) {
        pcs.removePropertyChangeListener(listener);
    }

    public PropertyChangeListener[] getPropertyChangeListeners() {
        return pcs.getPropertyChangeListeners();
    }
}