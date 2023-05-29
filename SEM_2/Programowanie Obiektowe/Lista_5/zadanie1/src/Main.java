public class Main {
    public static void main(String[] args) {
        // Tworzenie drzewa arytmetycznego
        Expression expr1 = new Add(new Const(4), new Variable("x"));
        Variable x = new Variable("x");
        x.setValue(3);
        Expression expr2 = new Subtract(new Const(7), new Const(2));
        Expression expr3 = new Add(new Variable("y"), new Const(5));
        Variable y = new Variable("y");
        y.setValue(2);
        Expression expr4 = new Subtract(new Add(new Const(3), new Variable("z")), new Const(1));
        Variable z = new Variable("z");
        z.setValue(5);
        Expression expr5 = new Add(new Const(2), new Subtract(new Const(8), new Variable("w")));
        Variable w = new Variable("w");
        w.setValue(1);
        
        // Testowanie metody toString() i metody evaluate()
        System.out.println("expr1 = " + expr1.toString() + ", expr1.evaluate() = " + (x.evaluate() + expr1.evaluate())); // expr1 = (4 + x), expr1.evaluate() = 7
        System.out.println("expr2 = " + expr2.toString() + ", expr2.evaluate() = " + expr2.evaluate()); // expr2 = (7 - 2), expr2.evaluate() = 5
        System.out.println("expr3 = " + expr3.toString() + ", expr3.evaluate() = " + (y.evaluate() + expr3.evaluate())); // expr3 = (y + 5), expr3.evaluate() = 7
        System.out.println("expr4 = " + expr4.toString() + ", expr4.evaluate() = " + (z.evaluate() + expr4.evaluate())); // expr4 = ((3 + z) - 1), expr4.evaluate() = 7
        System.out.println("expr5 = " + expr5.toString() + ", expr5.evaluate() = " + (expr5.evaluate() - w.evaluate())); // expr5 = (2 + (8 - w)), expr5.evaluate() = 9

    }
}
