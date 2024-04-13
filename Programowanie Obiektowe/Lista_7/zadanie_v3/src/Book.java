import java.io.*;

public class Book implements Serializable {
    String name;
    int prize;
    String author;


    public Book() {
    }

    public Book(String name, int prize, String author) {
        this.name = name;
        this.prize = prize;
        this.author = author;
    }

    @Override
    public String toString() {
        return "Książka: " + this.name + " " ;
    }

    public void save(String filename){
        try{
            FileOutputStream fos = new FileOutputStream(filename);
            ObjectOutputStream oos = new ObjectOutputStream(fos);
            oos.writeObject(this);
            oos.close();
            System.out.println("Zapisano pomyślnie");
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    public Book read(String filename) {
        Book book = null;
        try {
            FileInputStream fis = new FileInputStream(filename);
            ObjectInputStream ois = new ObjectInputStream(fis);
            book = (Book) ois.readObject();
            ois.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return  book;
    }
}
