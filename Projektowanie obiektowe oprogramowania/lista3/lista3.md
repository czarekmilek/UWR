# Lista 3 | POO

## Zadanie 1
![image](https://hackmd.io/_uploads/HkBJ_-w3Jg.png)

**Creator:** Klasa `Order` odpowiada za tworzenie obiektów `OrderItem`, bo *posiada* dane do ich utworzenia.
**Information Expert:** Klasa `Order` posiada wszystkie informacje o swoich elementach i dlatego oblicza łączną wartość zamówienia.

```java
// Klasa reprezentująca pojedynczy element zamówienia
public class OrderItem {
    private String name;
    private int quantity;
    private double unitPrice;

    public OrderItem(String name, int quantity, double unitPrice) {
        this.name = name;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
    }

    public String getName() { return name; }
    public int getQuantity() { return quantity; }
    public double getUnitPrice() { return unitPrice; }
}

// Klasa reprezentująca zamówienie
import java.util.ArrayList;
import java.util.List;

public class Order {
    private List<OrderItem> items;

    public Order() {
        items = new ArrayList<>();
    }

    // Zasada Creator – Order tworzy obiekt OrderItem,
    // ponieważ "zawiera" dane do jego utworzenia.
    public void addItem(String name, int quantity, double unitPrice) {
        items.add(new OrderItem(name, quantity, unitPrice));
    }

    // Zasada Information Expert – Order zna swoje elementy
    // i potrafi obliczyć łączną wartość.
    public double calculateTotal() {
        double total = 0;
        for (OrderItem item : items) {
            total += item.getUnitPrice() * item.getQuantity();
        }
        return total;
    }
}
```
![image](https://hackmd.io/_uploads/rJ9Q0uD3Jx.png)
<!-- public class Task1Demo {
    public static void main(String[] args) {
        Order order = new Order();
        order.addItem("Produkt A", 2, 10.0);
        order.addItem("Produkt B", 1, 20.0);
        double total = order.calculateTotal();
        System.out.println("Łączna wartość zamówienia: " + total);
    }
} -->

---

## Zadanie 2
![image](https://hackmd.io/_uploads/B1ixuWwn1l.png)

Początkowo jedna klasa `ReportPrinter` łączy w sobie pobieranie danych, formatowanie oraz drukowanie raportu. Podzielimy to na trzy oddzielne klasy.

### Przed zmianami
```java
// Klasa łącząca pobieranie danych, formatowanie i drukowanie raportu
public class ReportPrinter {
    public String getData() {
        return "Dane raportu";
    }

    public void formatDocument() {
        System.out.println("Dokument sformatowany");
    }

    public void printReport() {
        System.out.println("Raport wydrukowany");
    }
}
```

### Po zmianach
```java
public class ReportDataProvider {
    public String getData() {
        return "Dane raportu";
    }
}
```

```java
public class ReportFormatter {
    public String formatReport(String data) {
        return "Sformatowany raport: " + data;
    }
}
```

```java
public class ReportPrinter {
    public void printReport(String formattedReport) {
        System.out.println(formattedReport);
    }
}
```
![image](https://hackmd.io/_uploads/B1xRAOv3Jl.png)
<!-- public class Task2Demo {
    public static void main(String[] args) {
        ReportDataProvider dataProvider = new ReportDataProvider();
        ReportFormatter formatter = new ReportFormatter();
        ReportPrinter printer = new ReportPrinter();

        String data = dataProvider.getData();
        String formatted = formatter.formatReport(data);
        printer.printReport(formatted);
    }
}
 -->
**Odpowiedzi na pytania:**
- Powstają trzy klasy.
- Refaktoryzacja klasy naruszającej SRP nie oznacza, że każda metoda musi trafić do osobnej klasy. Kluczowe jest grupowanie tak, że grupy stanowią jedną spójną odpowiedzialność.

---

## Zadanie 3
![image](https://hackmd.io/_uploads/Sy5YiWDnJe.png)
![image](https://hackmd.io/_uploads/Byj9j-v31l.png)

Początkowa implementacja klasy `CashRegister` realizuje dwie odpowiedzialności (obliczanie podatku i drukowanie paragonu) bez możliwości łatwej rozbudowy.

Refaktoryzacja będzie polegać na wprowadzeniu interfejsów, które umożliwiają łatwe rozszerzenie funkcjonalności.

### Przed refaktoryzacją

```csharp
public class TaxCalculator {
    public decimal CalculateTax(decimal price) {
        return price * 0.22m;
    }
}

public class Item {
    public decimal Price { get; set; }
    public string Name { get; set; }
}

public class CashRegister {
    public TaxCalculator taxCalc = new TaxCalculator();

    public decimal CalculatePrice(Item[] items) {
        decimal total = 0;
        foreach (var item in items) {
            total += item.Price + taxCalc.CalculateTax(item.Price);
        }
        return total;
    }

    public string PrintBill(Item[] items) {
        foreach (var item in items)
            Console.WriteLine("towar {0} : cena {1} + podatek {2}",
                item.Name, item.Price, taxCalc.CalculateTax(item.Price));
        return "Paragon wydrukowany";
    }
}
```

### Po refaktoryzacji

```csharp
// Interfejs dla kalkulatora podatku
public interface ITaxCalculator {
    decimal CalculateTax(decimal price);
}

// Domyślna implementacja
public class DefaultTaxCalculator : ITaxCalculator {
    public decimal CalculateTax(decimal price) => price * 0.22m;
}

// Przykładowa alternatywna implementacja taryfy specjalnej
public class SpecialTaxCalculator : ITaxCalculator {
    public decimal CalculateTax(decimal price) => price * 0.15m;
}

// Interfejs dla drukarki paragonu
public interface IBillPrinter {
    string PrintBill(Item[] items, ITaxCalculator taxCalculator);
}

// Implementacja drukarki sortującej alfabetycznie
public class BillPrinterAlphabetical : IBillPrinter {
    public string PrintBill(Item[] items, ITaxCalculator taxCalculator) {
        var sortedItems = items.OrderBy(i => i.Name).ToArray();
        StringBuilder sb = new StringBuilder();
        foreach (var item in sortedItems) {
            sb.AppendLine($"towar {item.Name} : cena {item.Price} + podatek {taxCalculator.CalculateTax(item.Price)}");
        }
        return sb.ToString();
    }
}

// Implementacja drukarki sortującej według ceny rosnąco
public class BillPrinterByPrice : IBillPrinter {
    public string PrintBill(Item[] items, ITaxCalculator taxCalculator) {
        var sortedItems = items.OrderBy(i => i.Price).ToArray();
        StringBuilder sb = new StringBuilder();
        foreach (var item in sortedItems) {
            sb.AppendLine($"towar {item.Name} : cena {item.Price} + podatek {taxCalculator.CalculateTax(item.Price)}");
        }
        return sb.ToString();
    }
}
```
```csharp
public class CashRegister {
    private readonly ITaxCalculator _taxCalculator;
    private readonly IBillPrinter _billPrinter;

    // Wstrzykiwanie zależności
    public CashRegister(ITaxCalculator taxCalculator, IBillPrinter billPrinter) {
        _taxCalculator = taxCalculator;
        _billPrinter = billPrinter;
    }

    public decimal CalculatePrice(Item[] items) {
        decimal total = 0;
        foreach (var item in items) {
            total += item.Price + _taxCalculator.CalculateTax(item.Price);
        }
        return total;
    }

    public string PrintBill(Item[] items) {
        return _billPrinter.PrintBill(items, _taxCalculator);
    }
}
```
![image](https://hackmd.io/_uploads/B14UlFv3kg.png)
<!-- using System;

public class Task3Demo {
    public static void Main() {

        Item[] items = new Item[] {
            new Item { Name = "Produkt A", Price = 10m },
            new Item { Name = "Produkt B", Price = 20m },
            new Item { Name = "Produkt C", Price = 15m }
        };

        // Używamy domyślnego kalkulatora podatku i drukarki sortującej alfabetycznie
        ITaxCalculator taxCalculator = new DefaultTaxCalculator();
        IBillPrinter billPrinter = new BillPrinterAlphabetical();
        CashRegister register = new CashRegister(taxCalculator, billPrinter);

        decimal totalPrice = register.CalculatePrice(items);
        Console.WriteLine("Łączna cena: " + totalPrice);

        string bill = register.PrintBill(items);
        Console.WriteLine("Paragon:\n" + bill);
    }
} -->
---

## Zadanie 4
![image](https://hackmd.io/_uploads/ryg5M_DhJg.png)

Oryginalna hierarchia (gdzie `Square` dziedziczy po `Rectangle`) może prowadzić do nieoczekiwanego zachowania.
Lepszym rozwiązaniem jest stworzenie wspólnego interfejsu `Shape`, który definiuje metodę obliczania pola, a klasy `Rectangle` i `Square` implementują ją zgodnie ze swoimi właściwościami.

```csharp
// Interfejs reprezentujący kształt
public interface IShape {
    int GetArea();
}

public class Rectangle : IShape {
    public int Width { get; set; }
    public int Height { get; set; }

    public int GetArea() {
        return Width * Height;
    }
}

public class Square : IShape {
    public int Side { get; set; }

    public int GetArea() {
        return Side * Side;
    }
}
```
```csharp
public class AreaCalculator {
    public int CalculateArea(IShape shape) {
        return shape.GetArea();
    }
}
```
![image](https://hackmd.io/_uploads/SJhhgKwhJg.png)
<!--
using System;

public class Task4Demo {
    public static void Main() {
        IShape rectangle = new Rectangle(4, 5);
        IShape square = new Square(5);

        AreaCalculator calc = new AreaCalculator();
        Console.WriteLine("Pole prostokąta: " + calc.CalculateArea(rectangle));
        Console.WriteLine("Pole kwadratu: " + calc.CalculateArea(square));
    }
}
 -->

---

## Zadanie 5
![image](https://hackmd.io/_uploads/Hyw5XuwnJx.png)

Przykładem z biblioteki .NET może być interfejs **IUserStore\<TUser>**.

Interfejs ten definiuje szereg metod, takich jak:
![image](https://hackmd.io/_uploads/B19UHuvh1e.png)

Nie każda implementacja UserStore musi korzystać ze wszystkich metod – niektóre systemy mogą np. potrzebować tylko wyszukiwania, a nie modyfikacji.

Narusza to ISP, bo zmuszamy klasę implementującą interfejs do implementowania nieużywanych metod.

### Proponowana refaktoryzacja
Podzielić interfejs na mniejsze, bardziej wyspecjalizowane interfejsy, np.:

```csharp
public interface IUserCreator<TUser> {
    Task CreateAsync(TUser user, CancellationToken cancellationToken);
}

public interface IUserUpdater<TUser> {
    Task UpdateAsync(TUser user, CancellationToken cancellationToken);
}

public interface IUserDeleter<TUser> {
    Task DeleteAsync(TUser user, CancellationToken cancellationToken);
}

public interface IUserFinder<TUser> {
    Task<TUser> FindByIdAsync(string userId, CancellationToken cancellationToken);
    Task<TUser> FindByNameAsync(string normalizedUserName, CancellationToken cancellationToken);
}
```

Implementacje mogą wybrać tylko te interfejsy, które są im potrzebne, dzięki czemu klient nie jest zmuszony do zależności od metod, których nie używa.


---

## Zadanie 6
![image](https://hackmd.io/_uploads/HyDL8_vhyg.png)

**SRP (Single Responsibility Principle)**
- Dotyczy projektowania klas
- Każda klasa powinna mieć tylko jedną odpowiedzialność, czyli tylko jeden powód do zmiany.
- **Przykład**: Klasa odpowiedzialna za pobieranie danych nie powinna zajmować się ich formatowaniem ani drukowaniem.

**ISP (Interface Segregation Principle)**
- Dotyczy projektowania interfejsów
- Klient nie powinien być zmuszany do bycia zależnym od metod, których nie używa.
- **Przykład**: Zamiast implementować duży interfejs zawierający wiele metod, lepiej podzielić go na mniejsze interfejsy, z których klient wybiera tylko te, które są mu potrzebne.

---

## Zadanie 7
![image](https://hackmd.io/_uploads/rJBa8_whJx.png)

W tym przykładzie wprowadzamy klasę `ReportComposer`, która łączy usługi odpowiedzialne za pobieranie danych, formatowanie oraz drukowanie raportu. Zależności są wstrzykiwane przez interfejsy.

#### Definicja interfejsów dla usług

```java
public interface IReportDataProvider {
    String getData();
}
```

```java
public interface IReportFormatter {
    String formatReport(String data);
}
```

```java
public interface IReportPrinter {
    void printReport(String formattedReport);
}
```

#### Implementacje

```java
public class ReportDataProviderImpl implements IReportDataProvider {
    @Override
    public String getData() {
        return "Dane raportu z bazy";
    }
}
```

```java
public class ReportFormatterImpl implements IReportFormatter {
    @Override
    public String formatReport(String data) {
        return "*** Sformatowany raport ***\n" + data;
    }
}
```

```java
public class ReportPrinterImpl implements IReportPrinter {
    @Override
    public void printReport(String formattedReport) {
        System.out.println(formattedReport);
    }
}
```

#### Klasa ReportComposer

```java
public class ReportComposer {
    private IReportDataProvider dataProvider;
    private IReportFormatter formatter;
    private IReportPrinter printer;

    public ReportComposer(IReportDataProvider dataProvider, IReportFormatter formatter, IReportPrinter printer) {
        this.dataProvider = dataProvider;
        this.formatter = formatter;
        this.printer = printer;
    }

    public void composeAndPrintReport() {
        String data = dataProvider.getData();
        String formatted = formatter.formatReport(data);
        printer.printReport(formatted);
    }
}
```

<!--
```java
public class Main {
    public static void main(String[] args) {
        IReportDataProvider dataProvider = new ReportDataProviderImpl();
        IReportFormatter formatter = new ReportFormatterImpl();
        IReportPrinter printer = new ReportPrinterImpl();

        ReportComposer composer = new ReportComposer(dataProvider, formatter, printer);
        composer.composeAndPrintReport();
    }
}
``` -->
![image](https://hackmd.io/_uploads/B1hhbFD2Jg.png)
