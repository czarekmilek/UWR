using System.Collections;

public class ComparisonComparer<T> : IComparer
{
  private readonly Comparison<T> _comparison;

  public ComparisonComparer(Comparison<T> comparison)
  {
    if (comparison == null)
      throw new ArgumentNullException(nameof(comparison));
    _comparison = comparison;
  }

  public int Compare(object x, object y)
  {
    return _comparison((T)x, (T)y);
  }
}

class Program
{
  static int IntComparer(int x, int y)
  {
    return x.CompareTo(y);
  }

  static void Main()
  {
    ArrayList a = new ArrayList() { 1, 5, 3, 3, 2, 4, 3 };

    a.Sort(new ComparisonComparer<int>(IntComparer));

    foreach (int i in a)
    {
      Console.Write(i + " ");
    }
  }
}
