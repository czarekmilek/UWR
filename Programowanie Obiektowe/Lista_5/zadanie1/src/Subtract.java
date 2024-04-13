public class Subtract extends Operation {
    public Subtract(Expression left, Expression right) {
        super(left, right);
    }
    public int evaluate() {
        return left.evaluate() - right.evaluate();
    }

    public String toString() {
        return "(" + left.toString() + " - " + right.toString() + ")";
    }
}