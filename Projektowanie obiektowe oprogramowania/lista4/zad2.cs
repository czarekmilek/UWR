using System;
using System.Collections.Generic;
using NUnit.Framework;

#region Open Delegate Factory

public interface IShape
{
  double Area { get; }
}

public class Square : IShape
{
  public double Side { get; }
  public Square(double side) { Side = side; }
  public double Area => Side * Side;
}

public class Rectangle : IShape
{
  public double Width { get; }
  public double Height { get; }
  public Rectangle(double width, double height) { Width = width; Height = height; }
  public double Area => Width * Height;
}

public interface IShapeFactoryWorker
{
  bool CanCreate(string shapeName);
  IShape Create(params object[] parameters);
}

public class DefaultShapeWorker : IShapeFactoryWorker
{
  // Domyślny pracownik tworzy kwadraty
  public bool CanCreate(string shapeName)
  {
    return string.Equals(shapeName, "Square", StringComparison.OrdinalIgnoreCase);
  }

  public IShape Create(params object[] parameters)
  {
    if (parameters.Length != 1)
      throw new ArgumentException("Square wymaga jednego parametru (bok).");
    double side = Convert.ToDouble(parameters[0]);
    return new Square(side);
  }
}

public class RectangleFactoryWorker : IShapeFactoryWorker
{
  public bool CanCreate(string shapeName)
  {
    return string.Equals(shapeName, "Rectangle", StringComparison.OrdinalIgnoreCase);
  }

  public IShape Create(params object[] parameters)
  {
    if (parameters.Length != 2)
      throw new ArgumentException("Rectangle wymaga dwóch parametrów (szerokość i wysokość).");
    double width = Convert.ToDouble(parameters[0]);
    double height = Convert.ToDouble(parameters[1]);
    return new Rectangle(width, height);
  }
}

public class ShapeFactory
{
  private readonly List<IShapeFactoryWorker> _workers = new List<IShapeFactoryWorker>();

  public ShapeFactory()
  {
    // Domyślnie rejestrujemy pracownika tworzącego kwadraty.
    _workers.Add(new DefaultShapeWorker());
  }

  public void RegisterWorker(IShapeFactoryWorker worker)
  {
    if (worker == null)
      throw new ArgumentNullException(nameof(worker));
    _workers.Add(worker);
  }

  public IShape CreateShape(string shapeName, params object[] parameters)
  {
    foreach (var worker in _workers)
    {
      if (worker.CanCreate(shapeName))
      {
        return worker.Create(parameters);
      }
    }
    throw new ArgumentException($"Nie znaleziono pracownika dla kształtu: {shapeName}");
  }
}

#endregion

#region Testy Jednostkowe dla Open Delegate Factory

[TestFixture]
public class ShapeFactoryTests
{
  [Test]
  public void CreateSquare_ShouldReturnSquareInstance()
  {
    var factory = new ShapeFactory();
    IShape square = factory.CreateShape("Square", 5);
    Assert.That(square, Is.InstanceOf<Square>());
    Assert.That(25, Is.EqualTo(square.Area));
  }

  [Test]
  public void CreateRectangle_AfterRegisteringWorker_ShouldReturnRectangleInstance()
  {
    var factory = new ShapeFactory();
    // Rejestrujemy pracownika tworzącego prostokąty.
    factory.RegisterWorker(new RectangleFactoryWorker());
    IShape rectangle = factory.CreateShape("Rectangle", 3, 5);
    Assert.That(rectangle, Is.InstanceOf<Rectangle>());
    Assert.That(15, Is.EqualTo(rectangle.Area));
  }

  [Test]
  public void CreateShape_WithNonExistingShape_ShouldThrowException()
  {
    var factory = new ShapeFactory();
    Assert.That(() => factory.CreateShape("Circle", 5), Throws.Exception.TypeOf<ArgumentException>());
  }
}

#endregion
