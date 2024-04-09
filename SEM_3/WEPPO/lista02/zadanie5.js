// Definicja nowego obiektu
const myObject = {};

// Dodawanie pola do obiektu
myObject.myField = 'Wartość pola';

// Dodawanie metody do obiektu
myObject.myMethod = function() {
  console.log('To jest moja metoda');
};

// Dodawanie właściwości z akcesorami get i set
let _myProperty = 'Wartość początkowa właściwości';
Object.defineProperty(myObject, 'myProperty', {
  get: function() {
    return _myProperty;
  },
  set: function(value) {
    _myProperty = value;
  }
});

// Wywołanie metody
myObject.myMethod();

// Odczyt wartości pola
console.log(myObject.myField);

// Odczyt i zmiana wartości właściwości z akcesorami get i set
console.log(myObject.myProperty);
myObject.myProperty = 'Nowa wartość właściwości';
console.log(myObject.myProperty);
  
//////////////////////////////////////

// Dodawanie nowego pola do istniejącego obiektu
myObject.newField = 'Nowe pole';

// Dodawanie nowej metody do istniejącego obiektu
myObject.newMethod = function() {
console.log('To jest nowa metoda');
};

// Dodawanie nowej właściwości z akcesorami get i set do istniejącego obiektu
let _newProperty = 'Wartość początkowa nowej właściwości';
Object.defineProperty(myObject, 'newProperty', {
get: function() {
    return _newProperty;
},
set: function(value) {
    _newProperty = value;
}
});

// Wywołanie nowej metody
myObject.newMethod();

// Odczyt nowego pola
console.log(myObject.newField);

// Odczyt i zmiana wartości nowej właściwości z akcesorami get i set
console.log(myObject.newProperty);
myObject.newProperty = 'Nowa wartość nowej właściwości';
console.log(myObject.newProperty);