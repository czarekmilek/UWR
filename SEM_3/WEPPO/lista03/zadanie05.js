function createGenerator(limit) {
    return function(){ //dodatkowo dodajemy tą linijkę, aby prawidłowo zwrócić wynik
    var _state = 0;
    return {
      next: function () {
        return {
          value: _state,
          done: _state++ >= limit //zmieniamy stałą wartość 10 na limit, który dostaje nasza funkcja
        };
      }
    };
  }
}

// foo wzięte z zadania
var foo = {
    [Symbol.iterator]: createGenerator
};

//Type error: undefined is not a function: dla f w for (var f of foo)
//for (var f of foo) console.log(f);

var test = {
    [Symbol.iterator]: createGenerator(7)
};

for ( var f of test ) console.log(f);

console.log("---------");

var test1 = {
    [Symbol.iterator]: createGenerator(37)
};

for ( var f of test1 ) console.log(f);

console.log("---------");

var test2 = {
    [Symbol.iterator]: createGenerator(101)
};

for ( var f of test2 ) console.log(f);

console.log("---------");
