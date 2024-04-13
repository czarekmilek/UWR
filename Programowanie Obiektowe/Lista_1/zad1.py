from collections import namedtuple
from math import pi

Figura = namedtuple("Figura", ["typ", "x", "y", "pole"])

def new_square(x, y, bok):
    if bok < 0:
        raise ValueError("Bok kwadratu nie może być ujemny!")
    return Figura("kwadrat", x, y, bok * bok)

def new_circle(x, y, promien):
    if promien < 0:
        raise ValueError("Promień koła nie może być ujemny!")
    return Figura("koło", x, y, pi * promien * promien)

def new_triangle(x, y, bok):
    if bok < 0:
        raise ValueError("Bok trójkąta nie może być ujemny!")
    return Figura("trójkąt", x, y, (bok * bok * 3 ** 0.5) / 4)

def pole(f):
    return f.pole

def przesun(f, x, y):
    return Figura(f.typ, f.x + x, f.y + y, f.pole)

def show(f):
    print(f"Typ: {f.typ}, Współrzędne: ({f.x}, {f.y}), Pole: {f.pole}")

def sumapol(figury):
    return sum([f.pole for f in figury])

# Tworzenie figur
f1 = new_square(1.0, -1.0, 3.0)
f2 = new_circle(2.0, 2.0, 1.0)
f3 = new_triangle(-1.0, 1.0, 2.0)

# Wyświetlanie informacji o figurach
show(f1) # Figura: Kwadrat, pozycja: (1.0, -1.0)
show(f2) # Figura: Koło, pozycja: (2.0, 2.0)
show(f3) # Figura: Trójkąt, pozycja: (-1.0, 1.0)

# Przesuwanie figur i wyliczanie ich pól
przesun(f1, 1.0, 1.0)
przesun(f2, -2.0, 3.0)
przesun(f3, 1.0, -1.0)

print(pole(f1)) # 9.0
print(pole(f2)) # 3.141592653589793
print(pole(f3)) # 1.5

# Sumowanie pól figur w tablicy
tablica_figur = [f1, f2, f3]
print(sumapol(tablica_figur, len(tablica_figur))) # 13.641592653589793
