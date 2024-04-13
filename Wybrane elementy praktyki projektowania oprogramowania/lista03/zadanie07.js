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

function* take(it, top){
    for(let i = 0; i < top; i++){
        const result = it.next();
        if(result.done) 
            return;
        yield result.value;
    }
}

for(let num of take(fibg(), 10)){
    console.log(num);
}

console.log("--------------")

for(let num of take(fibi(), 10)){
    console.log(num);
}

//infinity
// for ( var i of fibg() ) { console.log( i ); }