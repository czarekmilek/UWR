package aquarium;

import java.util.Random;

public class Regulator implements Runnable {
    private final Grzalka grzalka;
    private final Random random = new Random();

    public Regulator(Grzalka grzalka) {
        this.grzalka = grzalka;
    }

    @Override
    public void run() {
        try {
            while (!Thread.currentThread().isInterrupted()) {
                if (random.nextBoolean()) {
                    grzalka.increaseTemp();
                } else {
                    grzalka.decreaseTemp();
                }
                Thread.sleep(random.nextInt(1000) + 500);
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}