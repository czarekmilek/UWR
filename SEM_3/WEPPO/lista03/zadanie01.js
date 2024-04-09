
function fibg(n){
    if(n <= 0){
        return 0;
    }
    else if(n == 1){
        return 1;
    }
    else{
        return (fibg(n - 1) + fibg(n - 2))
    }
}

function fibi(n){
    if(n <= 1){
        return n;
    }
    else{
        var fib0 = 0;
        var fib1 = 1;
        for(var i = 1; i < n; i++){
            var fib2 = fib0 + fib1;
            fib0 = fib1;
            fib1 = fib2;
        }
        return fib1;
    }
}

function mem(fn){
    //zapamiętujemy nasze wyniki
    var cache = {};
    
    return function(n) {
    
    //sprawdzamy czy policzyliśmy to już wcześniej,
    //jeśli tak to zwracamy wynik
    if ( n in cache ) {
        return cache[n]
    //jeśli nie to zapamiętujemy wynik
    } else {
        var result = fn(n);
        cache[n] = result;
        return result;
        }
    }
}
   

const fibmem = mem((n) => {
    if(n == 0)
        return 0;
    if(n == 1)
        return 1;
    return fibmem(n - 1) + fibmem(n - 2);
});


for(let i = 0; i <= 45; i++){ //Po 44 różnica w czasie wykonania przekracza 10s
    console.log(`Pomiar dla ${i}`);
    // console.time(`Rekurencyjnie`);
    // fibg(i);
    // console.timeEnd(`Rekurencyjnie`);

    console.time(`Iteracyjnie`);
    fibi(i);
    console.timeEnd(`Iteracyjnie`);

    console.time(`Memoizacyjnie`);
    fibmem(i);
    console.timeEnd(`Memoizacyjnie`);
    console.log();

}

/*
```
Pomiar dla 0
Rekurencyjnie: 0.332ms
Iteracyjnie: 0.11ms
Memoizacyjnie: 0.207ms

Pomiar dla 1
Rekurencyjnie: 0.022ms
Iteracyjnie: 0.013ms
Memoizacyjnie: 0.012ms

Pomiar dla 2
Rekurencyjnie: 0.017ms
Iteracyjnie: 0.013ms
Memoizacyjnie: 0.013ms

Pomiar dla 3
Rekurencyjnie: 0.076ms
Iteracyjnie: 0.009ms
Memoizacyjnie: 0.022ms

Pomiar dla 4
Rekurencyjnie: 0.013ms
Iteracyjnie: 0.022ms
Memoizacyjnie: 0.027ms

Pomiar dla 5
Rekurencyjnie: 0.055ms
Iteracyjnie: 0.032ms
Memoizacyjnie: 0.034ms

Pomiar dla 6
Rekurencyjnie: 0.015ms
Iteracyjnie: 0.012ms
Memoizacyjnie: 0.049ms

Pomiar dla 7
Rekurencyjnie: 0.013ms
Iteracyjnie: 0.01ms
Memoizacyjnie: 0.014ms

Pomiar dla 8
Rekurencyjnie: 0.025ms
Iteracyjnie: 0.01ms
Memoizacyjnie: 0.012ms

Pomiar dla 9
Rekurencyjnie: 0.024ms
Iteracyjnie: 0.028ms
Memoizacyjnie: 0.036ms

Pomiar dla 10
Rekurencyjnie: 0.032ms
Iteracyjnie: 0.011ms
Memoizacyjnie: 0.034ms

Pomiar dla 11
Rekurencyjnie: 0.034ms
Iteracyjnie: 0.009ms
Memoizacyjnie: 0.018ms

Pomiar dla 12
Rekurencyjnie: 0.047ms
Iteracyjnie: 0.009ms
Memoizacyjnie: 0.018ms

Pomiar dla 13
Rekurencyjnie: 0.072ms
Iteracyjnie: 0.01ms
Memoizacyjnie: 0.011ms

Pomiar dla 14
Rekurencyjnie: 1.915ms
Iteracyjnie: 0.015ms
Memoizacyjnie: 0.024ms

Pomiar dla 15
Rekurencyjnie: 0.053ms
Iteracyjnie: 0.01ms
Memoizacyjnie: 0.015ms

Pomiar dla 16
Rekurencyjnie: 0.052ms
Iteracyjnie: 0.021ms
Memoizacyjnie: 0.018ms

Pomiar dla 17
Rekurencyjnie: 0.079ms
Iteracyjnie: 0.008ms
Memoizacyjnie: 0.052ms

Pomiar dla 18
Rekurencyjnie: 0.125ms
Iteracyjnie: 0.011ms
Memoizacyjnie: 0.019ms

Pomiar dla 19
Rekurencyjnie: 0.527ms
Iteracyjnie: 0.017ms
Memoizacyjnie: 0.023ms

Pomiar dla 20
Rekurencyjnie: 0.22ms
Iteracyjnie: 0.01ms
Memoizacyjnie: 0.022ms

Pomiar dla 21
Rekurencyjnie: 0.313ms
Iteracyjnie: 0.01ms
Memoizacyjnie: 0.016ms

Pomiar dla 22
Rekurencyjnie: 0.564ms
Iteracyjnie: 0.008ms
Memoizacyjnie: 0.011ms

Pomiar dla 23
Rekurencyjnie: 0.801ms
Iteracyjnie: 0.006ms
Memoizacyjnie: 0.021ms

Pomiar dla 24
Rekurencyjnie: 1.766ms
Iteracyjnie: 0.016ms
Memoizacyjnie: 0.015ms

Pomiar dla 25
Rekurencyjnie: 2.089ms
Iteracyjnie: 0.007ms
Memoizacyjnie: 0.012ms

Pomiar dla 26
Rekurencyjnie: 2.015ms
Iteracyjnie: 0.011ms
Memoizacyjnie: 0.012ms

Pomiar dla 27
Rekurencyjnie: 6.008ms
Iteracyjnie: 0.014ms
Memoizacyjnie: 0.024ms

Pomiar dla 28
Rekurencyjnie: 8.814ms
Iteracyjnie: 0.007ms
Memoizacyjnie: 0.011ms

Pomiar dla 29
Rekurencyjnie: 14.353ms
Iteracyjnie: 0.012ms
Memoizacyjnie: 0.022ms

Pomiar dla 30
Rekurencyjnie: 24.074ms
Iteracyjnie: 0.008ms
Memoizacyjnie: 0.011ms

Pomiar dla 31
Rekurencyjnie: 37.976ms
Iteracyjnie: 0.023ms
Memoizacyjnie: 0.025ms

Pomiar dla 32
Rekurencyjnie: 63.423ms
Iteracyjnie: 0.015ms
Memoizacyjnie: 0.016ms

Pomiar dla 33
Rekurencyjnie: 85.148ms
Iteracyjnie: 0.013ms
Memoizacyjnie: 0.015ms

Pomiar dla 34
Rekurencyjnie: 139.442ms
Iteracyjnie: 0.018ms
Memoizacyjnie: 0.01ms

Pomiar dla 35
Rekurencyjnie: 181.742ms
Iteracyjnie: 0.007ms
Memoizacyjnie: 0.012ms

Pomiar dla 36
Rekurencyjnie: 258.208ms
Iteracyjnie: 0.011ms
Memoizacyjnie: 0.015ms

Pomiar dla 37
Rekurencyjnie: 397.606ms
Iteracyjnie: 0.008ms
Memoizacyjnie: 0.011ms

Pomiar dla 38
Rekurencyjnie: 738.124ms
Iteracyjnie: 0.02ms
Memoizacyjnie: 0.015ms

Pomiar dla 39
Rekurencyjnie: 1.088s
Iteracyjnie: 0.007ms
Memoizacyjnie: 0.015ms

Pomiar dla 40
Rekurencyjnie: 1.701s
Iteracyjnie: 0.008ms
Memoizacyjnie: 0.011ms

Pomiar dla 41
Rekurencyjnie: 1.729s
Iteracyjnie: 0.013ms
Memoizacyjnie: 0.014ms

Pomiar dla 42
Rekurencyjnie: 2.926s
Iteracyjnie: 0.005ms
Memoizacyjnie: 0.008ms

Pomiar dla 43
Rekurencyjnie: 4.669s
Iteracyjnie: 0.005ms
Memoizacyjnie: 0.016ms
Pomiar dla 44
Rekurencyjnie: 7.564s
Iteracyjnie: 0.006ms
Memoizacyjnie: 0.01ms

Pomiar dla 45
Rekurencyjnie: 12.769s
Memoizacyjnie: 0.02ms


```
*/