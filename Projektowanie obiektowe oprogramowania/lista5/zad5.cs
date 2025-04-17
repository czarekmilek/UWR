public interface IService
{
  void Execute();
}

public class RealService : IService
{
  public void Execute()
  {
    Console.WriteLine("RealService: wykonanie operacji.");
    // throw new Exception("Błąd wykonania.");
  }
}

// Retry Proxy – ponawia wywołanie, gdy wystąpi wyjątek
public class RetryProxy : IService
{
  private readonly IService _realService;
  private readonly int _maxRetries;

  public RetryProxy(IService realService, int maxRetries = 3)
  {
    _realService = realService;
    _maxRetries = maxRetries;
  }

  public void Execute()
  {
    int attempt = 0;
    while (true)
    {
      try
      {
        _realService.Execute();
        break; // Sukces – wychodzimy z pętli
      }
      catch (Exception ex)
      {
        attempt++;
        Console.WriteLine($"RetryProxy: próba {attempt} nieudana. Błąd: {ex.Message}");
        if (attempt >= _maxRetries)
          throw;
      }
    }
  }
}

// Logging Proxy – loguje wywołania metody Execute
public class LoggingProxy : IService
{
  private readonly IService _realService;

  public LoggingProxy(IService realService)
  {
    _realService = realService;
  }

  public void Execute()
  {
    Console.WriteLine($"{DateTime.Now:F} | LoggingProxy: wywołanie metody Execute rozpoczęte.");
    _realService.Execute();
    Console.WriteLine($"{DateTime.Now:F} | LoggingProxy: wywołanie metody Execute zakończone.");
  }
}

public static class ServiceProxyFactory
{
  public static IService CreateRetryProxy(IService service, int maxRetries = 3)
  {
    return new RetryProxy(service, maxRetries);
  }

  public static IService CreateLoggingProxy(IService service)
  {
    return new LoggingProxy(service);
  }
}

public class Program
{
  public static void Main(string[] args)
  {
    // LoggingProxy
    IService realService = new RealService();
    Console.WriteLine("=== Testing LoggingProxy ===");
    IService loggingService = ServiceProxyFactory.CreateLoggingProxy(realService);
    loggingService.Execute();

    // Console.WriteLine();

    // RetryProxy
    // Console.WriteLine("=== Testing RetryProxy ===");
    // IService retryService = ServiceProxyFactory.CreateRetryProxy(realService);
    // try
    // {
    //   retryService.Execute();
    // }
    // catch (Exception ex)
    // {
    //   Console.WriteLine($"Final failure after retries: {ex.Message}");
    // }
  }
}
