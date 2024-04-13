function forEach<T>(a: T[], f: (t: T) => void): void {
    for (const x of a) {
        f(x);
    }
}

function map<T, U>(a: T[], f: (t: T) => U): U[] {
    const result: U[] = [];
    for (const x of a) {
        result.push(f(x));
    }
    return result;
}

function filter<T>(a: T[], p: (t: T) => boolean): T[] {
    const result: T[] = [];
    for (const x of a) {
        if (p(x)) {
            result.push(x);
        }
    }
    return result;
}

const a = [1, 2, 3, 4];

console.log("Wywołanie z pomocą funkcji strzałkowych:");

// forEach
forEach(a, (_) => {
    console.log(_);
});

// filter
console.log(filter(a, (_) => _ < 3));

// map
console.log(map(a, (_) => _ * 2));

console.log("\nWywołanie z pomocą zwykłej funkcji:");

// forEach
forEach(a, function(x) {
    console.log(x);
});

// filter
console.log(filter(a, function(x) {
    return x < 3;
}));

// map
console.log(map(a, function(x) {
    return x * 2;
}));
