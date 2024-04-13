/*
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
*/

//generyczny typ, aby memoizacja działała dla każdej funkcji
type MemoizedFunction<T> = (n: any) => T;

function memoize<T>(fn: (n: number) => T): MemoizedFunction<T> {
    // zapamiętujemy nasze wyniki
    const cache: Record<number, T> = {};    //zmiana

    return function(n: number): T {         //drobna zmiana
        // sprawdzamy, czy policzyliśmy to już wcześniej,
        // jeśli tak, to zwracamy wynik
        if (n in cache) {
            return cache[n];
        // jeśli nie, to zapamiętujemy wynik
        } else {
            const result: T = fn(n);        //drobna zmiana
            cache[n] = result;
            return result;
        }
    };
}

function fib(n: number): number { //jedyna zmiana to podanie typu
    if (n <= 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return fib(n - 1) + fib(n - 2);
    }
}

const memoizedFib: MemoizedFunction<number> = memoize(fib);

const result: number = memoizedFib(13);
console.log(result);
