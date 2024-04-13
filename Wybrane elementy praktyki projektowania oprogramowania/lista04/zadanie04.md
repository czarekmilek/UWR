W języku JavaScript, wartości typów prostych (takie jak liczby, ciągi znaków, boolean itp.) nie posiadają prototypów tak jak obiekty. Wartości te są niezmienialne (immutable) i nie zachowują się jak obiekty. Jednak w pewnym sensie JS automatycznie opakowuje te wartości w odpowiednie obiekty, tzw. *wrappery*.

W przypadku liczby `n = 1`, JavaScript automatycznie opakowuje ją w obiekt typu `Number` (jeden z wrapperów). Obiekty tego typu mają prototyp, ale wartość liczby sama w sobie nie ma. 

```javascript
var n = 1;
// liczba ma prototyp?
console.log(typeof Object.getPrototypeOf(n)); // "object" - wynika to z obiektowego opakowania

// można jej dopisać pole/funkcję?
n.foo = 'foo';
console.log(n.foo); // undefined - wartość liczby nie posiada pola "foo"
```

Wynik `typeof Object.getPrototypeOf(n)` jest *"object"*, ponieważ `n` zostało automatycznie opakowane w obiekt `Number`. Jednak próba dodania pola "foo" do `n` nie zmieni samej wartości liczbowej. Wartość liczby nie posiada pola/funkcji, więc `n.foo` będzie `undefined`.

Podsumowując, chociaż wartości typów prostych w JavaScript są opakowywane w obiekty podczas pewnych operacji, same wartości liczbowe, ciągi znaków itp. nie posiadają prototypów ani możliwości dodawania pola/funkcji, ponieważ są niezmienialne.