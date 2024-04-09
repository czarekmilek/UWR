
console.log(
  (![] + [])[+[]] +
  // ![] -> false 
  //(![] + []) -> false + [] -> false
  //+[] -> 0 
  //false[0] = 'f'

  (![] + [])[+!+[]] +
  // (![] + []) -> false
  // +[] -> 0
  //!0 -> true
  //+true -> 1
  //false[1] = 'a'

  ([![]] + [][[]])[+!+[] + [+[]]] +
  //![] -> false
  //[![]] -> [false]
  //[][[]] -> undefined
  //([false] + undefined) -> 'falseundefined'
  // +!+[] -> 1
  //[+[]] -> [0]
  //1 + [0] -> '10'
  // 'falseundefined'['10'] -> 'i'
  (![] + [])[!+[] + !+[]]
  //(![] + []) -> false
  //!+[] -> true
  //true + true -> 2
  //false[2] = 'l'
);

console.log(
    (![] + [])[+[]] +  // Wynik: 'f' (false[0] = 'f')
    (![] + [])[+!+[]] +  // Wynik: 'a' (false[1] = 'a')
    ([![]] + [][[]])[+!+[] + [+[]]] +  // Wynik: 'i' ('falseundefined'[10] = 'i')
    (![] + [])[!+[] + !+[]]  // Wynik: 'l' (false[2] = 'l')
  );

  //fail
  