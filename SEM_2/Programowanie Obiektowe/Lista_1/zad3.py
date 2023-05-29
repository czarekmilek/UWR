from typing import List, Tuple, TypeVar

T = TypeVar('T')

def nowa_tablica() -> List[T]:
    return []

def dodaj(tablica: List[T], indeks: int, element: T) -> None:
    if len(tablica) == 0:
        tablica.append(None)
    while indeks < -len(tablica) or indeks >= len(tablica):
        tablica.append(None)
    tablica[indeks] = element

def indeks(tablica: List[T], indeks: int) -> T:
    if len(tablica) == 0:
        return None
    elif indeks < -len(tablica) or indeks >= len(tablica):
        return None
    else:
        return tablica[indeks]

def show(tablica: List[T]) -> None:
    print(tablica)

# Tworzymy nową tablicę
t = nowa_tablica()

# Wstawiamy wartości na pozycje -3, 2 i 5
dodaj(t, -3, 1)
dodaj(t, 2, 2)
dodaj(t, 5, 3)

# Sprawdzamy wartości na wybranych pozycjach
print(indeks(t, -3)) # powinno zwrócić 1
print(indeks(t, 0)) # powinno zwrócić 0
print(indeks(t, 2)) # powinno zwrócić 2
print(indeks(t, 5)) # powinno zwrócić 3

# Wyświetlamy całą tablicę
show(t) # powinno wyświetlić [1, 0, 2, 0, 0, 3]
