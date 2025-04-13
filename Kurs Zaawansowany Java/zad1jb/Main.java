package aquarium;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Grzalka grzalka = new Grzalka();
        grzalka.setThermostat(new Thermostat());

        Rybka rybka1 = new Rybka("1", 15, 26);
        Rybka rybka2 = new Rybka("2", 14, 29);
        Rybka rybka3 = new Rybka("3", 18, 25);

        grzalka.addPropertyChangeListener(rybka1);
        grzalka.addPropertyChangeListener(rybka2);
        grzalka.addPropertyChangeListener(rybka3);

        List<Thread> threads = new ArrayList<>();
        for (int i = 0; i < 3; i++) {
            Thread t = new Thread(new Regulator(grzalka));
            threads.add(t);
            t.start();
        }

        new Thread(() -> {
            while (true) {
                int aliveFish = countAliveFish(grzalka);
                if (aliveFish == 0) {
                    System.out.println("Wszystkie rybki umarły. Wyłączanie grzałki.");
                    threads.forEach(Thread::interrupt);
                    System.exit(0);
                }
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    System.out.println(e.getMessage());
                }
            }
        }).start();
    }

    private static int countAliveFish(Grzalka grzalka) {
        return (int) Arrays.stream(grzalka.getPropertyChangeListeners())
                .filter(listener -> listener instanceof Rybka)
                .count();
    }
}