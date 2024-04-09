// Funkcja getLastProto
function getLastProto(o) {
    var p = o;
    do {
        o = p;
        p = Object.getPrototypeOf(o);
    } while (p);

    return o;
}

// Tworzymy kilka obiektów
var obj1 = 13;
var obj2 = "STRING";
var obj3 = {};

// Sprawdzamy łańcuch prototypów dla każdego obiektu
var lastProto1 = getLastProto(obj1);
var lastProto2 = getLastProto(obj2);
var lastProto3 = getLastProto(obj3);

// Sprawdzamy równość referencji
console.log(lastProto1 === lastProto2); // Powinno być true
console.log(lastProto1 === lastProto3); // Powinno być true
console.log(lastProto2 === lastProto3); // Powinno być true
console.log(lastProto1);
// console.log(lastProto1)