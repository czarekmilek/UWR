# Lista 2 | POO

## Zadanie 1
![image](https://hackmd.io/_uploads/BylUJEE31g.png)
![image](https://hackmd.io/_uploads/rJdvH4O3kx.png)

- Strzałka między `ConcreteCommand`, a `AbstractCommand` - dziedziczenie
- Strzałka między `AbstractCommand`, a `ICommand` - implementacja interfejsu
- `ConcreteCommand` ma asocjacje do `CommandStepBuilder`

## Zadanie 2
![image](https://hackmd.io/_uploads/BkH_yNNh1x.png)

> **Definicja**: Diagram obiektów ma pokazać konkretne instancje i ich powiązania w danym momencie działania systemu.

![image](https://hackmd.io/_uploads/Hk189BEnyx.png)

## Zadanie 3
![image](https://hackmd.io/_uploads/HJ6u1ENhyl.png)

**Urządzenie**: Ekspres do kawy

- **Idle** – ekspres czeka na działanie użytkownika
- **SelectingDrink** – użytkownik wybiera rodzaj kawy.
- **AwaitingPayment** – użytkownik musi wnieść opłatę.
- **Brewing** – ekspres przygotowuje kawę.
- **Dispensing** – ekspres wydaje gotowy napój do kubka.
- **Error** – np. brak wody, brak kawy, brak kubków itp.
- **Maintenance** – stan, w którym ekspres jest wyłączony z użytkowania i obsługiwany przez serwis.

![image](https://hackmd.io/_uploads/rybQBIV2Je.png)

## Zadanie 4
![image](https://hackmd.io/_uploads/SkrY1E4h1l.png)
![image](https://hackmd.io/_uploads/rk92BPVhJx.png)
![image](https://hackmd.io/_uploads/HJ6B9PV2Jx.png)


## Zadanie 5
![image](https://hackmd.io/_uploads/HyAKyN4n1l.png)
![image](https://hackmd.io/_uploads/SJlBi_4h1e.png)

## Zadanie 6
![image](https://hackmd.io/_uploads/H1FcJEN2Jl.png)
![image](https://hackmd.io/_uploads/rJc-Cu42yx.png)

## Zadanie 7
![image](https://hackmd.io/_uploads/SJusy443yx.png)
![image](https://hackmd.io/_uploads/H1x2kE43ke.png)

```plaintext
class Student:
    indeksStudenta
    listaKursow studenta

    funkcja getCourses():
        zwróć listaKursow

class UsosWebPage:
    kontrolerOcen

    funkcja show():
        pageLayout = kontrolerOcen.getStudentGradeInfo()

class GradeController:
    student

    funkcja getStudentGradeInfo():
        listaOcen = pusta lista
        kursyStudenta = student.getCourses()

        dla kazdego kurs w kursyStudenta wykonaj:
            ocena = kurs.getMark(student)
            dodaj ocena do listaOcen

        zwróć listaOcen

class Course:
    listaOcenWKursie
    wybranyStudent

    funkcja getMark(student):
        wybranyStudent = student
        zwróć getValue()

    funkcja getValue():
        indeksStudenta = wybranyStudent.indeksStudenta
        zwróć listaOcenWKursie[indeksStudenta]
```

## Zadanie 8
![image](https://hackmd.io/_uploads/H1621VN2yx.png)
![image](https://hackmd.io/_uploads/B1MDcqNhJx.png)
