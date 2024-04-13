/*
Cezary Miłek
zadanie 4, lista 6
Program wykonania zadania:
IntelliJ IDEA Community Edition 2022.3.3
 */

public class Main
{
    public static void main(String[] args)
    {
        //nieposortowana tablica do testu działania Merge_Sort
        int[] test = {9321, 3124, 21112, 32161, 74217, 53211, 912, -3321, 64447};

        System.out.println("Przed sortowaniem: ");
        for (int i = 0; i < test.length; i++)
            System.out.println(test[i]);

        Merge_Sort sort = new Merge_Sort(test, 0, test.length - 1);
        Thread thread  = new Thread(sort);

        try {thread.start(); thread.join();}
        catch (InterruptedException e) {e.printStackTrace();}

        System.out.println("Po sortowaniu: ");
        for (int i = 0; i < test.length; i++)
            System.out.println(test[i]);
    }
}