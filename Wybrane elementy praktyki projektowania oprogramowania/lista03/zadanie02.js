function forEach(a, f){
    for(const x of a){
        f(x);
    }
}

function map(a, f){
    const result = [];
    for(const x of a){
        result.push(f(x));
    }
    return result;
}

function filter(a, p){
    const result = [];
    for(const x of a){
        if(p(x))
            result.push(x);
    }
    return result;
}

var a = [1,2,3,4];

console.log("Wywołanie z pomocą funkcji strzałkowych:")
forEach( a, _ => { console.log( _ ); } );
// a.forEach( _ => { console.log( _ ); } );
// [1,2,3,4]

console.log(filter( a, _ => _ < 3 ));
// [1,2]

console.log(map( a, _ => _ * 2 ));
// [2,4,6,8]

//:::::::::::::::::::::::::::::::::::::::::::::::::::::

console.log("\nWywołanie z pomocą zwykłej funkcji:")
forEach( a, function(x) { console.log( x ); } );
// [1,2,3,4]

console.log(filter(a, function(x) { return x < 3; } ));
// [1,2]

console.log(map(a, function(x) {return x * 2;}))