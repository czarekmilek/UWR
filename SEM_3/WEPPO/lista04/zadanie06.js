function Tree(val, left, right) {
    this.left = left;
    this.right = right;
    this.val = val;
}

// Tree.prototype[Symbol.iterator] = function*() {
//     yield this.val;
//     if ( this.left ) yield* this.left;
//     if ( this.right ) yield* this.right;
//     }
    
Tree.prototype[Symbol.iterator] = function* () {
    const queue = [this];

    while (queue.length > 0) {
        const node = queue.shift(); //usunięcie pierwszego elementu z tablicy
  
        // jeśli prawe - dodajemy do kolejki
        // jeśli lewe - dodajemy do kolejki
        // wypisujemy pierwszy element kolejki
        if (node.left) 
            queue.push(node.left);
        if (node.right) 
            queue.push(node.right);
        yield node.val;
    }
};
  
var root = new Tree(1, new Tree(2, new Tree(3)), new Tree(4));

//     1
//   2   4
// 3  - -  -
//- -- - -- -
// 142 --  wypisane: 1 
// 42 --   wypisane: 1, 4 
// 23 --   wypisane: 1, 4, 2 
// null -- wypisane: 1, 4, 2, 3 

for (var e of root) {
    console.log(e);
}

// Gdybyśmy dali stos to prawdopodobnie mielibyśmy iterator w głąb (bo zawsze przetwarzalibyśmy najnowszy węzeł, nie najwcześniejszy)