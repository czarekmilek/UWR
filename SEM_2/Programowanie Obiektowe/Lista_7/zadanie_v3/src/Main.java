public class Main {
    public void changeFile(String fileName, String className){
        switch (className){
            case "Book":
                Book book = new Book();
                book = book.read(fileName);
                BookSwing bs = new BookSwing(book);
                break;
            case "Publication":
                Publication publication = new Publication();
                publication =(Publication) publication.read(fileName);
                PublicationSwing ps = new PublicationSwing(publication);
                break;
            default:
                    System.out.println("Błąd");
        }
    }
    public static void main(String[] args) {
       Main main = new Main();
       main.changeFile("Publication.txt","Publication");
       main.changeFile("Book.txt","Book");
    }
}
