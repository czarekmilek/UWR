// Moduł A - a.js
function functionA() {
    const B = require('./b'); // Import wewnątrz funkcji
    console.log('Funkcja A');
    B.functionB();
}

module.exports = {
    functionA: functionA
};
