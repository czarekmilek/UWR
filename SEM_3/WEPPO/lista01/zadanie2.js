
function div_each(n){
    const x = n;
    var num = 0;
    while(n != 0){
        num = n % 10;
        n = Math.floor(n / 10);

        if(x % num != 0){
            return false;
        }
    }
    return true;
}

function div_sum(n){
    var sum = 0;
    const x = n;
    while(n != 0){
        sum += (n % 10);
        n = Math.floor(n / 10);
    }
    if(x % sum === 0){
        return true;
    } 
    return false;
}

const result = [];

for(let i = 1; i <= 100000; i++){
    if(div_each(i) && div_sum(i)){
        result.push(i);
    }
}

console.log(result.join(" "));