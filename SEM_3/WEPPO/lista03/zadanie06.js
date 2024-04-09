//iterator
function fibi() {
    let a = 1, b = 1;
    return {
      next: function () {
        const value = a;
        a = b;
        b += value;
  
        return {
          value,
          done: false,
        };
      },
    };
}

// generator
function* fibg(){
    let a = 1, b = 1;
    yield a;
    yield b;
    while(true){
        let p = a;
        a = b;
        b = p + b;
        yield b;
    }
}

// var _it = fibi();
// for ( var _result; _result = _it.next(), !_result.done; ) { console.log( _result.value );
//}

// wypisanie
function fibonacci_numbers(source, limit){
    let i = 0;
    for(const number of source){
        i += 1;
        if(i > limit){
            break;
        }
        console.log(number);
    }
    console.log("----------------------");
}

const test = {
    [Symbol.iterator]: fibi
};
fibonacci_numbers(test, 13);

const test2 = {
    [Symbol.iterator]: fibg
};
fibonacci_numbers(test2, 13);

// const test_bad = fibi(); //dla fibi nie da się tak
// fibonacci_numbers(test_bad, 101); // TypeError: source is not iterable

const test_good = fibg();
// fibonacci_numbers(test_good, 1500);