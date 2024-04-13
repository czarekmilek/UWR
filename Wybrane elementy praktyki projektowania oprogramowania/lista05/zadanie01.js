
const A = require('./a');
const B = require('./b');

A.functionA();
// Cykl zależności między modułami występuje, ponieważ moduł A importuje moduł B, a moduł B importuje moduł A