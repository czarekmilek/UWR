from collections import deque

def konwersja(wyrazenie_infiksowe):
    def power_of_op(operator):
        power_op = {'+': 1, '-': 1, '*': 2, '/': 2, '^': 3}
        return power_op.get(operator, 0)

    def is_op(x):
        return x in "+-*/^"

    def infix_to_onp(wyr_infiks):
        output = deque()
        stack = deque()

        for x in wyr_infiks:
            if isinstance(x, int):
                output.append(x)
            elif x == '(':
                stack.append(x)
            elif x == ')':
                while stack and stack[-1] != '(':
                    output.append(stack.pop())
                stack.pop()  # Usuń otwierający nawias '('
            elif is_op(x):
                while (stack and is_op(stack[-1]) and
                       power_of_op(x) <= power_of_op(stack[-1])):
                    output.append(stack.pop())
                stack.append(x)
        
        while stack:
            output.append(stack.pop())

        return output

    return list(infix_to_onp(wyrazenie_infiksowe))

def oblicz(wyrazenie_onp):
    stack = deque()

    for x in wyrazenie_onp:
        if isinstance(x, int):
            stack.append(x)
        elif isinstance(x, str):
            b = stack.pop()
            a = stack.pop()
            if x == '+':
                stack.append(a + b)
            elif x == '-':
                stack.append(a - b)
            elif x == '*':
                stack.append(a * b)
            elif x == '/':
                stack.append(a / b)
            elif x == '^':
                stack.append(a ** b)

    return stack.pop()

# Przykłady użycia
testINF = ['(', 2, '+', 3, ')', '*', 4]
testONP = konwersja(testINF)
testRES = oblicz(testONP)

print("Infix:", testINF)
print("ONP:", testONP)
print("Wynik:", testRES)
print("---------------------")
testINF1 = [2, '+', 3]
testONP1 = konwersja(testINF1)
testRES1 = oblicz(testONP1)

print("Infix 1:", testINF1)
print("ONP 1:", testONP1)
print("Result 1:", testRES1)

testINF2 = ['(', 5, '-', 2, ')', '*', 3, '/', 4]
testONP2 = konwersja(testINF2)
testRES2 = oblicz(testONP2)
print("---------------------")
print("Infix 2:", testINF2)
print("ONP 2:", testONP2)
print("Result 2:", testRES2)

testINF3 = ['(', 2, '+', 3, ')', '*', 2, '^', 3]
testONP3 = konwersja(testINF3)
testRES3 = oblicz(testONP3)
print("---------------------")
print("Infix 3:", testINF3)
print("ONP 3:", testONP3)
print("Result 3:", testRES3)

testINF4 = ['(', 8, '-', 12, ')', '/', '(', -4, ')']
testONP4 = konwersja(testINF4)
testRES4 = oblicz(testONP4)
print("---------------------")
print("Infix 4:", testINF4)
print("ONP 4:", testONP4)
print("Result 4:", testRES4)

testINF5 = [2, '*', '(', 3, '+', 4, ')', '-', 5, '/', 2, '^', 2]
testONP5 = konwersja(testINF5)
testRES5 = oblicz(testONP5)
print("---------------------")
print("Infix 5:", testINF5)
print("ONP 5:", testONP5)
print("Result 5:", testRES5)