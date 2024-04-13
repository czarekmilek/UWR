#lang racket


S -> `(Elem) | List |
Elem -> Symbol | Number | String | Cons | Boolean | ,Elem | ,@Elem | List |
List -> `(ListContent)

ListContent -> Elem | Elem Rest
Rest -> Elem | ListContent

Symbol -> 'S
Number -> n
String -> "Any_String"
Cons -> (ANY . ANY)
Boolean -> #t / #f

;wyrażenie > `(,(+ 2 2) 3) zwróci listę '(4 3),
;ponieważ wyrażenie (+ 2 2) zostanie ewaluowane do wartości 4 i podstawione w miejsce operatora ,


;`(,@(list 1 2 3) 3) zwróci listę '(1 2 3 3), ponieważ lista (1 2 3) zostanie rozpakowana
;i jej elementy zostaną umieszczone w miejscu operatora ,@.
