public class Variable extends Expression {
    private String name;
    private int value;

    public Variable(String name) { this.name = name; }

    public int evaluate() { return value; }

    public void setValue(int value) { this.value = value; }

    public String toString() { return name; }
}
