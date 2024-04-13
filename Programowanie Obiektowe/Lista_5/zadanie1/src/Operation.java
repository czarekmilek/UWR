public abstract class Operation extends Expression {
    protected Expression left;
    protected Expression right;

    public Operation(Expression left, Expression right) {
        this.left = left;
        this.right = right;
    }

    public abstract int evaluate();
    public abstract String toString();
}
