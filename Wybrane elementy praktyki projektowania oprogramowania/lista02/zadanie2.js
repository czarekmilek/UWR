/*
|1. Użycie operatorów . oraz [] do odwoływania się do składowych obiektu.  |
|   – Jakie są różnice między tymi dwoma sposobami?                        |
*/
/*
Operator . jest używany, gdy nazwa właściwości jest stała i nie zawiera spacji ani innych znaków specjalnych, 
nie może ona zaczynać się od liczby, ani zawierać zmiennych. 
Operator [] pozwala na dostęp do właściwości, których nazwa jest dynamicznie generowana lub zawiera znaki specjalne.

. pozwala jedynie na statyczne klucze, a [] akceptuje dynamicne. 
Statyczny klucz - klucz jest wpisany bezpośrednio
Dynamiczny klucz - klucz jest ewaluowany z wyrażenia
*/
const person = {
    name: "Obelix",
    weight: 100,
    age: 30
};

console.log(person.name); // Obelix
const something = "age";
console.log(person.something); // undefined
console.log(person[something]); // 30
console.log(person["age"]); // 30
//console.log(person[age]); // ReferenceError

/*---------------------------------------

|2. Użycie argumentów innego typu niż string dla operatora [] dostępu do składowej obiektu.    |
|– Co się dzieje jeśli argumentem operatora jest liczba?                                    |
|– Co się dzieje jeśli argumentem operatora jest inny obiekt?                               |
|– Jaki wpływ na klucz pod jakim zapisana zostanie wartość ma programista w obu przypadkach?|
*/
/*
-   Jeśli argumentem operatora `[]` jest liczba, to JavaScript używa tej liczby jako indeksu, 
    aby uzyskać dostęp do odpowiedniej składowej tablicy.
-   Jeśli argumentem operatora `[]` jest inny obiekt, to ten obiekt zostanie przekonwertowany 
    na ciąg znaków za pomocą metody `toString()` i użyty jako klucz.
*/

const myArray = [10, 20, 30];
console.log(myArray[1]); // 20 (indeks jako liczba)

const myObject = { name: "Alice" };
console.log(myObject["name"]); // "Alice" (klucz jako string)

const key = { toString: () => "name" };
console.log(myObject[key]); // "Alice" (obiekt przekształcony na string)

// Programista ma wpływ na klucz pod jakim zapisana zostanie wartość w obu przypadkach 
// poprzez wybór odpowiedniego argumentu operatora `[]`.

/*-----------------------------
3. Użycie argumentów innego typu niż number dla operatora `[]` dostępu do tablicy:

-   Jeśli argumentem operatora `[]` jest napis, to JavaScript używa tej wartości jako klucza, 
    aby uzyskać dostęp do właściwości obiektu. Dla tablicy, jest to taktowane jak dostęp do własności zamiast indeksu.
-   Jeśli argumentem operatora `[]` jest inny obiekt, zachowuje się podobnie jak w przypadku obiektu.
*/
const myArray2 = [10, 20, 30];
myArray2["customProperty"] = "Hello";
//console.log(myArray2) // [ 10, 20, 30, customProperty: 'Hello' ]
console.log(myArray2["customProperty"]); // "Hello"

const key2 = { toString: () => "customProperty" };
console.log(myArray2[key2]); // "Hello"

/*
Jeśli zostanie dodana własność do tablicy pod kluczem, który nie jest liczbą, 
nie wpływa to na zawartość tablicy. 
Tablica pozostaje nienaruszona, a nowa własność zostaje dodana do obiektu reprezentującego tablicę.

----------------
- Możliwość ustawienia wartości atrybutu `length` tablicy:

Można ręcznie ustawić wartość atrybutu `length` tablicy, ale wpływa to na 
liczbę elementów w tablicy i może prowadzić do obcięcia lub rozszerzenia tablicy.
*/

const myArray3 = [10, 20, 30];
console.log(myArray3.length); // 3

myArray3.length = 2; // Obetnij tablicę do 2 elementów
console.log(myArray3); // [10, 20]

myArray3.length = 5; // Rozszerz tablicę do 5 elementów (dodawane są undefined)
console.log(myArray3); // [10, 20, undefined, undefined, undefined]

/*
Jeśli ustawimy wartość atrybutu `length` na mniejszą niż aktualna liczba elementów, 
elementy poza nową długością zostaną usunięte. 
Jeśli ustawisz wartość większą niż aktualna liczba elementów, tablica zostanie rozszerzona, 
a nowe elementy zostaną wypełnione wartością `undefined`.
*/
