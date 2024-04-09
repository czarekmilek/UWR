import numpy as np
import matplotlib.pyplot as plt

# Funkcja obliczająca wielomian interpolacyjny dla węzłów równoodległych
def interp_rownoodlegle(x, nodes):
    result = 1.0
    for node in nodes:
        result *= (x - node)
    return result

# Funkcja obliczająca węzły Czebyszewa
def chebyshev(n):
    return np.cos(((2 * np.arange(n + 1) + 1) * np.pi) / (2 * (n + 1)))


# Wybór stopnia wielomianu
n_values = range(50, 51)

# Ustawienia dla subplots
plt.figure(figsize=(14, 5))

# Rysowanie wykresów dla węzłów równoodległych
plt.subplot(1, 2, 1)
plt.title('Węzły równoodległe')
for n in n_values:
    nodes = np.linspace(-1, 1, n+1)
    x_values = np.linspace(-1, 1, 1000)
    y_values = [interp_rownoodlegle(x, nodes) for x in x_values]

    plt.plot(x_values, y_values, label=f'n={n}')

    # result = interp_rownoodlegle(0, nodes)
    # print(f'n={n}: \t{result}')

plt.legend()

print("---------------")

# Rysowanie wykresów dla węzłów Czebyszewa
plt.subplot(1, 2, 2)
plt.title('Węzły Czebyszewa')
for n in n_values:
    nodes = chebyshev(n)
    x_values = np.linspace(-1, 1, 1000)
    y_values = [interp_rownoodlegle(x, nodes) for x in x_values]

    plt.plot(x_values, y_values, label=f'n={n}')

    # result = interp_rownoodlegle(0, nodes)
    # print(f'n={n}: \t{result}')


plt.legend()

# Wyświetlenie wykresów
plt.show()
