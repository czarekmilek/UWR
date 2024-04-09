var n = 1;
// liczba ma prototyp?
console.log(typeof Object.getPrototypeOf(n)); // "object" - wynika to z obiektowego opakowania

// można jej dopisać pole/funkcję?
n.foo = 'foo';
console.log(n.foo); // undefined - wartość liczby nie posiada pola "foo"

