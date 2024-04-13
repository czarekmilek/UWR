function isPropertyInObjectOrPrototype(obj, propertyName) {
    return obj.hasOwnProperty(propertyName)
}
// sprawdza, czy dana składowa (propertyName) istnieje jako własność 
// bezpośrednio w obiekcie (obj.hasOwnProperty(propertyName)) 
// lub w jego łańcuchu prototypów

var p = {
    name: 'jan'
};

var q = {
    surname: 'kowalski'
};

Object.setPrototypeOf(p, q);

console.log(p.name)
console.log(p.surname)
console.log(q.name)

console.log(isPropertyInObjectOrPrototype(p, 'name'));    // true - name pochodzi z obiektu 'p'
console.log(isPropertyInObjectOrPrototype(p, 'surname')); // true - surname pochodzi z prototypu 'q'
console.log(isPropertyInObjectOrPrototype(p, 'age'));     // false - age nie istnieje ani w obiekcie 'p' ani w prototypie 'q'
console.log(isPropertyInObjectOrPrototype(q, 'name'));
