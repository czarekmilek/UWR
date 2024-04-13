import random
import math

def approximate_pi(n, tolerance):
    ltwo = 0    # Liczba trafień wewnątrz okręgu
    cltwt = 0   # Całkowita liczba trafień w tarczę
    current_pi = 0 
    iteration = 0

    while abs(current_pi - math.pi) >= tolerance and iteration < n:
        x = random.uniform(-1, 1)  # Losowa współrzędna x
        y = random.uniform(-1, 1)  # Losowa współrzędna y
        distance = x**2 + y**2 

        if distance <= 1:  # Jeśli punkt leży wewnątrz okręgu
            ltwo += 1

        cltwt += 1
        iteration += 1

        current_pi = 4 * ltwo / cltwt
        print(f"Przybliżenie π po {iteration} rzutach: {current_pi}")

    return current_pi

#result = approximate_pi(100000, 0.01)
#print(f"Ostateczne przybliżenie π: {result}")

#result = approximate_pi(100000, 0.001)
#print(f"Ostateczne przybliżenie π: {result}")

result = approximate_pi(100000, 0.0001)
print(f"Ostateczne przybliżenie π: {result}")

#result = approximate_pi(100000, 0.00001)
#print(f"Ostateczne przybliżenie π: {result}")
