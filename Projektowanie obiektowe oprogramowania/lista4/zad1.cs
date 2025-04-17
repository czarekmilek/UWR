using System;
using System.Threading;
using NUnit.Framework;

#region Singleton

// 1. Singleton procesowy
public sealed class ProcessSingleton
{
    private static readonly Lazy<ProcessSingleton> _instance =
        new Lazy<ProcessSingleton>(() => new ProcessSingleton());

    private ProcessSingleton() { }

    public static ProcessSingleton Instance => _instance.Value;
}

// 2. Singleton wątkowy
public sealed class ThreadSingleton
{
    [ThreadStatic]
    private static ThreadSingleton _instance;

    private ThreadSingleton() { }

    public static ThreadSingleton Instance
    {
        get
        {
            if (_instance == null)
                _instance = new ThreadSingleton();
            return _instance;
        }
    }
}

// 3. Singleton czasowy (5 sekund)
public sealed class TimeLimitedSingleton
{
    private static TimeLimitedSingleton _instance;
    private static DateTime _lastCreated;
    private static readonly object _lock = new object();

    private TimeLimitedSingleton() { }

    public static TimeLimitedSingleton Instance
    {
        get
        {
            lock (_lock)
            {
                // Jeśli instancja nie istnieje lub jej "życie" przekroczyło 5 sekund
                if (_instance == null || (DateTime.Now - _lastCreated).TotalSeconds > 5)
                {
                    _instance = new TimeLimitedSingleton();
                    _lastCreated = DateTime.Now;
                }
                return _instance;
            }
        }
    }
}

#endregion

#region Testy Jednostkowe

[TestFixture]
public class SingletonTests
{
    [Test]
    public void ProcessSingleton_ShouldReturnSameInstance()
    {
        var s1 = ProcessSingleton.Instance;
        var s2 = ProcessSingleton.Instance;
        Assert.That(s1, Is.SameAs(s2));
    }

    [Test]
    public void ThreadSingleton_ShouldReturnDifferentInstances_OnDifferentThreads()
    {
        ThreadSingleton instance1 = null;
        ThreadSingleton instance2 = null;

        var thread1 = new Thread(() => { instance1 = ThreadSingleton.Instance; });
        var thread2 = new Thread(() => { instance2 = ThreadSingleton.Instance; });

        thread1.Start();
        thread2.Start();
        thread1.Join();
        thread2.Join();

        // Instancje z różnych wątków powinny być różne
        Assert.That(instance1, Is.Not.SameAs(instance2));
    }

    [Test]
    public void TimeLimitedSingleton_ShouldReturnSameInstanceWithin5Seconds()
    {
        var instance1 = TimeLimitedSingleton.Instance;
        Thread.Sleep(3000);
        var instance2 = TimeLimitedSingleton.Instance;
        Assert.That(instance1, Is.SameAs(instance2));
    }

    [Test]
    public void TimeLimitedSingleton_ShouldReturnNewInstanceAfter5Seconds()
    {
        var instance1 = TimeLimitedSingleton.Instance;
        Thread.Sleep(5500);
        var instance2 = TimeLimitedSingleton.Instance;
        Assert.That(instance1, Is.Not.SameAs(instance2));
    }
}

#endregion
