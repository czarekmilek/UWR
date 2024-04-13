function createFs(n) {
    // tworzy tablicę n funkcji
    var fs = []; // i-ta funkcja z tablicy ma zwrócić i
    for (let i = 0; i < n; i++) { // w tym miejscu zmieniamy var na let - dzięki temu otrzymamy poprawne wyniki
      fs[i] = function () {
        return i;
      };
    }
    ;
    return fs;
  }

var myfs = createFs(10);
console.log(myfs[0]()); // zerowa funkcja miała zwrócić 0
console.log(myfs[2]()); // druga miała zwrócić 2
console.log(myfs[7]());
// 10 10 10 // ale wszystkie zwracają 10!?

/*
Gdy używamy var w pętli dla zmiennej i - mamy jedną zmienną i, którą współdzielą wszystkie funkcje w pętli.
W związku z tym funkcje w fs odnoszą się do tej samej wartości zmiennej i, czyli wartości n (wartość uzyskana
po zakończeniu pętli). Dlatego wszystkie funkcje zwracają nam 10.

Gdy używamy let w pętli dla zmiennej i - tworzymy nową zmienną i dla każdej iteracji w pętli.
W związku z tym każda funkcja w fs dostaje swoją własną wartość i, która ma odpowiednią wartość.
Dlatego wszystkie funkcje zwracają poprawne wyniki.
*/
console.log();

function return_itself(i){
    return function(){ return i; };
}

function createFs_new(n){ // tworzy tablicę n funkcji
    var fs = []; // i-ta funkcja z tablicy ma zwrócić i
    for(var i = 0; i < n; i++){
        fs[i] = return_itself(i)
    };
    return fs;
}

var myfs_new = createFs_new(10);
console.log(myfs_new[0]()); // zerowa funkcja miała zwrócić 0
console.log(myfs_new[2]()); // druga miała zwrócić 2
console.log(myfs_new[7]());
