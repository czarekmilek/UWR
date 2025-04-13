package obliczenia;

public abstract class Wyrazenie implements Obliczalny {

    public static double suma(Wyrazenie... wyr) {
        double sum = 0;
        for (Wyrazenie w : wyr) {
            sum += w.oblicz();
        }
        return sum;
    }

    public static double iloczyn(Wyrazenie... wyr) {
        double product = 1;
        for (Wyrazenie w : wyr) {
            product *= w.oblicz();
        }
        return product;
    }
}
