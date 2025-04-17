// Wyjątek rzucany, gdy zmienna nie została zdefiniowana w kontekście.
public class UndefinedVariableException : Exception
{
  public UndefinedVariableException(string variableName)
      : base($"Zmienna '{variableName}' nie została zdefiniowana.")
  { }
}

public class Context
{
  private Dictionary<string, bool> variables = new Dictionary<string, bool>();

  public bool GetValue(string variableName)
  {
    if (!variables.ContainsKey(variableName))
    {
      throw new UndefinedVariableException(variableName);
    }
    return variables[variableName];
  }

  public void SetValue(string variableName, bool value)
  {
    variables[variableName] = value;
  }
}

public abstract class AbstractExpression
{
  public abstract bool Interpret(Context context);
}

public class ConstExpression : AbstractExpression
{
  private readonly bool _value;

  public ConstExpression(bool value)
  {
    _value = value;
  }

  public override bool Interpret(Context context)
  {
    return _value;
  }
}

public class VariableExpression : AbstractExpression
{
  private readonly string _name;

  public VariableExpression(string name)
  {
    _name = name;
  }

  public override bool Interpret(Context context)
  {
    return context.GetValue(_name);
  }
}

public enum Operator { And, Or }

public class BinaryExpression : AbstractExpression
{
  private readonly AbstractExpression _left;
  private readonly AbstractExpression _right;
  private readonly Operator _operator;

  public BinaryExpression(AbstractExpression left, AbstractExpression right, Operator op)
  {
    _left = left;
    _right = right;
    _operator = op;
  }

  public override bool Interpret(Context context)
  {
    bool leftVal = _left.Interpret(context);
    bool rightVal = _right.Interpret(context);

    switch (_operator)
    {
      case Operator.And:
        return leftVal && rightVal;
      case Operator.Or:
        return leftVal || rightVal;
      default:
        throw new Exception("Nieznany operator");
    }
  }
}

public class UnaryExpression : AbstractExpression
{
  private readonly AbstractExpression _expression;

  public UnaryExpression(AbstractExpression expression)
  {
    _expression = expression;
  }

  public override bool Interpret(Context context)
  {
    return !(_expression.Interpret(context));
  }
}

public class ProgramInterpreter
{
  public static void Main(string[] args)
  {
    Context ctx = new Context();
    ctx.SetValue("x", false);
    ctx.SetValue("y", true);

    // !(x OR true) AND y
    // 'x OR true'
    AbstractExpression expr1 = new BinaryExpression(
        new VariableExpression("x"),
        new ConstExpression(true),
        Operator.Or
    );
    // NOT (x OR true)
    AbstractExpression expr2 = new UnaryExpression(expr1);
    // expr2 AND y
    AbstractExpression finalExpr = new BinaryExpression(
        expr2,
        new VariableExpression("y"),
        Operator.And
    );

    bool result = finalExpr.Interpret(ctx);
    Console.WriteLine("Wynik wyrażenia: " + result);

    ctx.SetValue("x", true);
    ctx.SetValue("y", false);

    // (x AND y) OR (NOT y)
    // x AND y
    AbstractExpression andExpression = new BinaryExpression(
        new VariableExpression("x"),
        new VariableExpression("y"),
        Operator.And
    );

    // NOT y
    AbstractExpression notExpression = new UnaryExpression(
        new VariableExpression("y")
    );

    // (x AND y) OR (NOT y)
    AbstractExpression finalExpression = new BinaryExpression(
        andExpression,
        notExpression,
        Operator.Or
    );

    result = finalExpression.Interpret(ctx);
    Console.WriteLine("Wynik wyrażenia: " + result);
  }
}
