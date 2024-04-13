class Formula:
    def __add__(self, w): #alternatywa
        return Or(self, w)

    def __mul__(self, w): #koniunkcja
        return And(self, w)

    def retSelf(self):
        return self

    def freeVars(self):
        if isinstance(self, And) or isinstance(self, Or):
            return self.w1.freeVars() | self.w2.freeVars()
        if isinstance(self, Not):
            return self.exp.freeVars()
        if isinstance(self, Zmienna):
            return {self.name}
        return set()
    
    def tautologia(w): 
        values = [dict()]
        for var in w.freeVars():
            newVals = []
            for val in values:
                newVals.append({**val, var:True})
                newVals.append({**val, var:False})
            values = newVals
        for val in values:
            if not(w.oblicz(val)):
                return False
        return True


class Zmienna(Formula):
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return self.name

    def oblicz(self, zmienne):
        if self.name in zmienne:
            if isinstance(zmienne[self.name], bool):
                return zmienne[self.name]
            raise WrongType("Warning: Wrong Type!")
        raise UnkownVar("Warning: Unkown Variable!")

class Stala(Formula): #t #f
    def __init__(self, value):
        self.value = value

    def __str__(self):
        if self.value:
            return "True"
        return "False"

    def oblicz(self, zmienne):
        if isinstance(self.value, bool):
            return self.value
        raise WrongType("Warning: Wrong Type!")

class Not(Formula):
    def __init__(self, exp):
        self.exp = exp

    def __str__(self):
        return f"¬{self.exp}"

    def oblicz(self, zmienne):
        return not(self.exp.oblicz(zmienne))

class Or(Formula):
    def __init__(self, w1, w2):
        self.w1 = w1
        self.w2 = w2
    
    def __str__(self):
        return f"({self.w1} ∨ {self.w2})"

    def oblicz(self, zmienne):
        return self.w1.oblicz(zmienne) or self.w2.oblicz(zmienne)

    def retSelf(self):
        if Formula.tautologia(self.w1):
            return Stala(True)
        if Formula.tautologia(self.w2):
            return Stala(True)
        if Formula.tautologia(self):
            return Stala(True)
        if Formula.tautologia(Not(self)):
            return Stala(False)
        if Formula.tautologia(Not(self.w1)):
            return self.w2.retSelf()
        if Formula.tautologia(Not(self.w2)):
            return self.w1.retSelf()
        return self.w1.retSelf() + self.w2.retSelf()


class And(Formula):
    def __init__(self, w1, w2):
        self.w1 = w1
        self.w2 = w2

    def __str__(self):
        return f"({self.w1} ∧ {self.w2})"

    def oblicz(self, zmienne):
        return self.w1.oblicz(zmienne) and self.w2.oblicz(zmienne)

    def retSelf(self):
        if Formula.tautologia(Not(self.w1)):
            return Stala(False)
        if Formula.tautologia(Not(self.w2)):
            return Stala(False)
        if Formula.tautologia(self):
            return Stala(True)
        if Formula.tautologia(Not(self)):
            return Stala(False)
        if Formula.tautologia(self.w1):
            return self.w2.retSelf()
        if Formula.tautologia(self.w2):
            return self.w1.retSelf()
        return self.w1.retSelf() * self.w2.retSelf()

class UnkownVar(Exception):
    pass

class WrongType(Exception):
    pass


# # Wypisywanie
print("Testy")
print(Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))), "  dla: p = True,    q = False   -> ", Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).oblicz({"p" : True,   "q" : False}))
print(Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))), "  dla: p = False,   q = False   -> ", Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).oblicz({"p" : False,  "q" : False}))
print(Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))), "  dla: p = True,    q = True    -> ", Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).oblicz({"p" : True,   "q" : True}))
print(Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))), "  dla: p = False,   q = True    -> ", Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).oblicz({"p" : False,  "q" : True}))
print()
print(Or(Not(Zmienna("p")), Zmienna("p")), "  dla: p = True\t->", Or(Not(Zmienna("p")), Zmienna("p")).oblicz({"p" : True}))
print(Or(Not(Zmienna("p")), Zmienna("p")), "  dla: p = False\t->", Or(Not(Zmienna("p")), Zmienna("p")).oblicz({"p" : False}))
print()
print(Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))), "  dla: p = True,    q = True    -> ", Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))).oblicz({"p" : True,   "q" : True}))
print(Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))), "  dla: p = True,    q = False   -> ", Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))).oblicz({"p" : True,   "q" : False}))
print(Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))), "  dla: p = False,   q = True    -> ", Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))).oblicz({"p" : False,   "q" : True}))
print(Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))), "  dla: p = False,   q = False   -> ", Or(Not(Or(Zmienna("p"), Zmienna("q"))), (Or(Zmienna("p"), Zmienna("q")))).oblicz({"p" : False,   "q" : False}))
# tautologia
print("\n---Testy .tautologia()---")
print(Zmienna("p"), "\t\t\t-> ", 
      Formula.tautologia(Zmienna("p"))) 
print((Or(Zmienna("p"), (Zmienna("q")))),"\t\t-> ", 
      Formula.tautologia(Or(Zmienna("p"), (Zmienna("q")))))
print((Or(Zmienna("p"), (Zmienna("p")))),"\t\t-> ", 
      Formula.tautologia(Or(Zmienna("p"), (Zmienna("p")))))
print(Or(Zmienna("p"), Not(Zmienna("p"))), "\t\t-> ", 
      Formula.tautologia(Or(Zmienna("p"), Not(Zmienna("p"))))) 
print(Or(Not(Or(Zmienna("p"), Zmienna("q"))), Or(Zmienna("p"), Zmienna("q"))), "\t-> ", 
      Formula.tautologia(Or(Or(Zmienna("p"), Zmienna("Q")), Not(Or(Zmienna("p"), Zmienna("Q")))))) 
print(Or(Stala(True), Zmienna("p")), "\t\t-> ", 
      Formula.tautologia(Or(Stala(True), Zmienna("p"))))
print(Not(Not(Zmienna("p"))), "\t\t\t-> ", 
      Formula.tautologia(Not(Not(Zmienna("p")))))
print(Not(Not(Stala(True))), "\t\t\t-> ", 
      Formula.tautologia(Not(Not(Stala(True)))))
print(Or(Not(Zmienna("p")), Zmienna("q")), "\t\t-> ", 
      Formula.tautologia(Or(Not(Zmienna("p")), Zmienna("q"))))
print(And(Zmienna("p"), Or(Zmienna("q"), Zmienna("r"))), "\t\t-> ", 
      Formula.tautologia(And(Zmienna("p"), Or(Zmienna("q"), Zmienna("r")))))
print(Not(And(Stala(True), Stala(True))), "\t\t-> ", 
      Formula.tautologia(Not(And(Stala(True), Stala(True)))))
print(Not(And(Stala(False), Stala(False))), "\t-> ", 
      Formula.tautologia(Not(And(Stala(False), Stala(False)))))

# ## uproszczenie
print("\nTesty uproszczeń")
print(Or(Stala(True), Stala(True)),"\t\t\t-> ",   Or(Stala(True), Stala(True)).retSelf())
print(Or(Zmienna("p"), Not(Zmienna("p"))),"\t\t\t-> ", Or(Zmienna("p"),   Not(Zmienna("p"))).retSelf())
print(And(Or(Zmienna("p"), Zmienna("q")), Or(Zmienna("r"), Not(Zmienna("r")))),"\t\t-> ",     And(Or(Zmienna("p"), Zmienna("q")), Or(Zmienna("r"), Not(Zmienna("r")))).retSelf())
print(And(Or(Zmienna("p"), (Or(Zmienna("q"), Zmienna("p")))), Or(Zmienna("r"), Not(Zmienna("r")))),"\t-> ",     And(Or(Zmienna("p"), Zmienna("q")), Or(Zmienna("r"), Not(Zmienna("r")))).retSelf())
print(Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))),"\t\t-> ",    Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).retSelf())

try:
    print("\nTesty niepoprawnych sytuacji")
    print("Nieznana wartość pod zmienną 'q'  -> ", Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).oblicz({"p":True}))
except (WrongType, UnkownVar) as e:
    print(str(e))

try:    
    print("Stała nie jest typu bool   -> ", Or(Not(Zmienna("p")), And(Zmienna("q"), Stala(True))).oblicz({"p":True, "q":123}))
except (WrongType, UnkownVar) as e:
    print(str(e))

