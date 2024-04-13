'''
Cezary Miłek
Zadanie 2 | Lista 1
Python 3.10 zad2.py
'''

from collections import namedtuple

def gcd(a, b):
    while b:
        a, b = b, a % b
    return a

Ulamek = namedtuple('Ulamek', ['num', 'denom'])

def nowy_ulamek(num, denom):
    d = gcd(num, denom)
    return Ulamek(num // d, denom // d)

def show(u):
    print(f"{u.num}/{u.denom}")

def dodaj(u1, u2):
    return Ulamek(u1.num * u2.denom + u1.denom * u2.num, u1.denom * u2.denom)

def odejmij(u1, u2):
    return Ulamek(u1.num * u2.denom - u1.denom * u2.num, u1.denom * u2.denom)

def pomnoz(u1, u2):
    u = Ulamek(u1.num * u2.num, u1.denom * u2.denom)
    return nowy_ulamek(u.num, u.denom)

def podziel(u1, u2):
    return Ulamek(u1.num * u2.denom, u1.denom * u2.num)



u1 = nowy_ulamek(8, 12)
u2 = nowy_ulamek(3, 4)

# test funkcji show
show(u1)  # 2/3
show(u2)  # 3/4

# test funkcji dodaj
u3 = dodaj(u1, u2)
show(u3)  # 17/12

# test funkcji odejmij
u4 = odejmij(u1, u2)
show(u4)  # -1/12

# test funkcji pomnoz
u5 = pomnoz(u1, u2)
show(u5)  # 1/2

# test funkcji podziel
u6 = podziel(u1, u2)
show(u6)  # 8/9
