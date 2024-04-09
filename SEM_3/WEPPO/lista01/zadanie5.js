
function fib(n){
    if(n <= 0){
        return 0;
    }
    else if(n == 1){
        return 1;
    }
    else{
        return (fib(n - 1) + fib(n - 2))
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

console.log(fib(19));
console.log(fibi(19));

for(let i = 0; i <= 45; i++){ //Po 44 różnica w czasie wykonania przekracza 10s
    console.log(`Pomiar dla ${i}`);
    console.time(`Rekurencyjnie`);
    fib(i);
    console.timeEnd(`Rekurencyjnie`);

    console.time(`Iteracyjnie`);
    fibi(i);
    console.timeEnd(`Iteracyjnie`);
    console.log();
}

/*
Pomiar dla 39
Rekurencyjnie: 868.926ms
Iteracyjnie: 0.009ms
Pomiar dla 40
Rekurencyjnie: 1.402s
Iteracyjnie: 0.006ms
Pomiar dla 41
Rekurencyjnie: 2.156s
Iteracyjnie: 0.006ms
Pomiar dla 42
Rekurencyjnie: 3.428s
Iteracyjnie: 0.008ms
Pomiar dla 43
Rekurencyjnie: 5.308s
Iteracyjnie: 0.007ms
Pomiar dla 44
Rekurencyjnie: 8.600s
Iteracyjnie: 0.006ms
Pomiar dla 45
Rekurencyjnie: 13.681s
Iteracyjnie: 0.004ms
*/