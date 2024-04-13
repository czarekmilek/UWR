public class Publication extends Book{
    int releaseYear;
    boolean aboutScience;
    boolean forStudents;

    public Publication() {
    }

    public Publication(String name, int prize, String author, int releaseYear, boolean aboutScience, boolean forStudents) {
        super(name, prize, author);
        this.releaseYear = releaseYear;
        this.aboutScience = aboutScience;
        this.forStudents = forStudents;
    }

    @Override
    public String toString() {
        return "Publikacja " + this.name;
    }
}
