function Foo() {
  // Zmienna prywatna dostępna tylko wewnątrz funkcji Foo
  // var privateVariable = 'To jest zmienna prywatna Foo';

  // Funkcja prywatna dostępna tylko wewnątrz funkcji Foo
  function Qux() {
    console.log('To jest funkcja prywatna Qux');
  }

  // Metoda publiczna Bar, która ma dostęp do funkcji prywatnej Qux
  this.Bar = function() {
    console.log('To jest metoda publiczna Bar');
    Qux(); // Wywołanie funkcji prywatnej Qux z metody publicznej Bar
  };
}

// Utworzenie instancji obiektu Foo
var instance = new Foo();

// Wywołanie metody publicznej Bar, która z kolei wywoła funkcję prywatną Qux
instance.Bar();
instance.Qux();