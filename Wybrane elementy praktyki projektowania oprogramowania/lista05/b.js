// Moduł B - b.js
function functionB() {
    const A = require('./a'); // Import wewnątrz funkcji
    console.log('Funkcja B');
    A.functionA();
}

module.exports = {
    functionB: functionB
};
