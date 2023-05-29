//program ilustrujący działanie zadania
public class Main {
    public static void main(String[] args) {
        OrderedList<StopienWojskowy> listaStopni = new OrderedList<>();
        listaStopni.addElement(new Szeregowy());
        listaStopni.addElement(new Kapral());
        listaStopni.addElement(new Sierzant());
        listaStopni.addElement(new Oficer());

        System.out.println("Pierwszy stopień: " + listaStopni.getFirst().getNazwa());
        System.out.println("Lista stopni: " + listaStopni);

        // porównanie stopni wojskowych
        StopienWojskowy szeregowy1 = new Szeregowy();
        StopienWojskowy szeregowy2 = new Szeregowy();
        StopienWojskowy kapral = new Kapral();
        StopienWojskowy sierzant = new Sierzant();
        StopienWojskowy oficer = new Oficer();
        // -1 -> ranga po lewej jest niższa niż ranga po prawej
        // 0 -> rangi są sobie równe
        // 1 -> ranga po lewej jest wyższa od tej po prawej
        System.out.println("Porównanie szeregowych: " + szeregowy1.compareTo(szeregowy2));
        System.out.println("Porównanie szeregowego z kapralem: " + szeregowy1.compareTo(kapral));
        System.out.println("Porównanie szeregowego z sierzantem: " + szeregowy1.compareTo(sierzant));
        System.out.println("Porównanie szeregowego z oficerem: " + szeregowy1.compareTo(oficer));
        System.out.println("Porównanie kaprala z szeregowym: " + kapral.compareTo(szeregowy1));
        System.out.println("Porównanie kaprala z sierzantem: " + kapral.compareTo(sierzant));
        System.out.println("Porównanie oficera z sierzantem: " + oficer.compareTo(sierzant));
    }
}
