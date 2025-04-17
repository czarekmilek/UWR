public interface ILogger
{
  void Log(string message);
}

public class ConsoleLogger : ILogger
{
  public void Log(string message)
  {
    Console.WriteLine(message);
  }
}

public class FileLogger : ILogger
{
  private readonly string filePath;

  public FileLogger(string path)
  {
    filePath = path;
  }

  public void Log(string message)
  {
    // Dodajemy każdy komunikat do pliku w nowej linii
    File.AppendAllText(filePath, message + Environment.NewLine);
  }
}

public class NullLogger : ILogger
{
  public void Log(string message)
  {
  }
}

public enum LogType
{
  None,
  Console,
  File
}

public class LoggerFactory
{
  private static LoggerFactory _instance;

  private LoggerFactory() { }

  public static LoggerFactory Instance
  {
    get
    {
      if (_instance == null)
      {
        if (_instance == null)
          _instance = new LoggerFactory();
      }
      return _instance;
    }
  }

  public ILogger GetLogger(LogType logType, string parameters = null)
  {
    switch (logType)
    {
      case LogType.Console:
        return new ConsoleLogger();
      case LogType.File:
        if (string.IsNullOrEmpty(parameters))
          throw new ArgumentException("Dla FileLogger należy podać ścieżkę do pliku.");
        return new FileLogger(parameters);
      case LogType.None:
      default:
        return new NullLogger();
    }
  }
}

public class Program
{
  public static void Main()
  {
    // Logger do pliku
    ILogger logger1 = LoggerFactory.Instance.GetLogger(LogType.File, @"M:\foo.txt");
    logger1.Log("Wiadomość do pliku");

    // Logger konsolowy
    ILogger logger2 = LoggerFactory.Instance.GetLogger(LogType.Console);
    logger2.Log("Wiadomość do konsoli");

    // Logger None
    ILogger logger3 = LoggerFactory.Instance.GetLogger(LogType.None);
    logger3.Log("Wiadomość nie logowana");
  }
}
