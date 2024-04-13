from decimal import *

def vat_faktura(lista):
    length = len(lista)
    sum = 0.0
    for i in range(length):
        sum = sum + lista[i]
    return sum * 0.23

def vat_paragon(lista):
    length = len(lista)
    sum = 0.0
    for i in range(length):
        sum = sum + lista[i] * 0.23
    return sum


#lista_test = [0.5, 5, 21, 42.99, 0.89, 13]              #False
#lista_test = [3, 1.1, 30, 101.99, 231, 40, 21.9]        #True
#lista_test = [3, 1.1, 30, 101.99, 231, 40, 21]         #False
#lista_test = [3.29, 32.12, 45.3, 23.12, 100.32, 1203.45] #True
lista_test = [0.5, 13, 21, 42.99, 0.99, 13]

print("\nvat_faktura: ", vat_faktura(lista_test))
print("vat_paragon: ", vat_paragon(lista_test))
print("Porównanie dla zwykłego lista_test: ", vat_faktura(lista_test) == vat_paragon(lista_test))

getcontext().prec = 16
print("\nDecimal(vat_faktura): ", Decimal(vat_faktura(lista_test)) * Decimal(1))
print("Decimal(vat_paragon): ", Decimal(vat_paragon(lista_test)) * Decimal(1))
print("Porównanie dla Decimalnego lista_test (prec = 16): ", Decimal(vat_faktura(lista_test)) * Decimal(1) == Decimal(vat_paragon(lista_test)) * Decimal(1))
#Mamy true aż do zwiększenia prec do 17
getcontext().prec = 17
print("\nDecimal(vat_faktura): ", Decimal(vat_faktura(lista_test)) * Decimal(1))
print("Decimal(vat_paragon): ", Decimal(vat_paragon(lista_test)) * Decimal(1))
print("Porównanie dla Decimalnego lista_test (prec = 17): ", Decimal(vat_faktura(lista_test)) * Decimal(1) == Decimal(vat_paragon(lista_test)) * Decimal(1))
