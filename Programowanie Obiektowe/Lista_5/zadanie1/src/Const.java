public class Const extends Expression {
    private int value;

    public Const(int value) { this.value = value; }

    public int evaluate() { return value; }

    public String toString() { return Integer.toString(value); }

}