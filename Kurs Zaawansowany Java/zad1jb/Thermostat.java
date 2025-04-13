package aquarium;

public class Thermostat {
    public boolean isChangeAllowed(int temperature) {
        return temperature >= 15 && temperature <= 30;
    }
}