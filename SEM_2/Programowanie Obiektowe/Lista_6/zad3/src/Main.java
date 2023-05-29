
public class Main
{
    public static void main(String[] args)
    {
        Bufor<String> Bufor = new Bufor<String>(13);

        Producent Producent = new Producent(Bufor);
        Konsument Konsument = new Konsument(Bufor);

        Producent.start();
        Konsument.start();
    }
}