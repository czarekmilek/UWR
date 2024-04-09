
function is_prime(n){
    if(n === 0 || n === 1){
        return false;
    }
    else if(n === 2){
        return true;
    }
    else{
        for(let i = 2; i < n; i++){
            if(n % i === 0){
                debugger;
                return false;
            }
        }
        return true;
    }
}

const result = [];

for(let i = 0; i <= 100000; i++){
    if(is_prime(i)){
        result.push(i);
    }
}

console.log(result.join(", "));