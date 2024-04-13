def pierwsze_imperatywna(n):
    result = []
    for number in range(2, n + 1):
        is_prime = True
        for i in range(2, int(number ** 0.5) + 1):
            if number % i == 0:
                is_prime = False
                break
        if is_prime:
            result.append(number)
    return result

def pierwsze_skladana(n):
    return [number for number in range(2, n + 1) if all(number % i != 0 for i in range(2, int(number ** 0.5) + 1))]

def pierwsze_funkcyjna(n):
    def is_prime(number):
        return all(number % i != 0 for i in range(2, int(number ** 0.5) + 1))
    
    return list(filter(is_prime, range(2, n + 1)))

print(pierwsze_imperatywna(101))
print(pierwsze_skladana(101))
print(pierwsze_funkcyjna(101))

import timeit

n_values = [1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]

print(f"  n\t\tskladana\timperatywna\tfunkcyjna")
for n in n_values:
    time_skladana    = timeit.timeit(f"pierwsze_skladana({n})",     globals=globals(), number=10000)
    time_imperatywna = timeit.timeit(f"pierwsze_imperatywna({n})",  globals=globals(), number=10000)
    time_funkcyjna   = timeit.timeit(f"pierwsze_funkcyjna({n})",    globals=globals(), number=10000)
    print(f"{n}:\t\t{time_skladana:.3f}\t\t{time_imperatywna:.3f}\t\t{time_funkcyjna:.3f}")

'''
  n             skladana        imperatywna     funkcyjna
1000:           12.387          5.767           9.607
2000:           21.366          12.280          20.971
3000:           33.306          21.846          36.363
4000:           45.936          26.601          45.828
5000:           57.142          33.857          58.074
6000:           69.532          42.447          70.912
7000:           82.533          47.841          86.207
8000:           95.530          55.000          100.936
9000:           112.438         62.969          113.932
10000:          125.131         75.088          130.155
'''