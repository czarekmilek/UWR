#lang racket


;pozytywne - funkcja przyjmująca dwa arg i zwraca pierwszy
;negatywne - funkcja przyjmująca dwa arg i zwraca drugi
(define/contract (pkt_1 a b)
  ( parametric->/c [a b] (-> a b a))
  a
  )


;pozytywne - funkcja przyjmuje 3 argmenty: f1 2 arg, f2 1 arg, typ a i zwraca wynik wywołania f1 z arg a i wynikiem f2 
;negatywne - funkcja przymie dla f1 wynik działania f2 i a - inna kolejność
;( parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
(define/contract (pkt_2 f1 f2 a)
  ( parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
  (f1 a (f2 a))
  )

;pozytywne - funkcja przyjmuje f1 1 arg i f2 1 arg i zwraca funkcję będącą złączenie f1 i f2
;negatywne - funkcja przyjmuje f1 i f2 w odwrotnej kolejności, wtedy nie uda się złączyć funkcji
;( parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
(define/contract (pkt_3 f1 f2)
  ( parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
  (lambda (x) (f1 (f2 x)) )
  )

;pozytywne - funkcja przyjmuje F, która przyjmuje f1, przyjmującą funkcję indentycznościową i same będąca funkcją identycznościową
;negatywne - funkjca, przyjmuje parametr a i F

(define/contract (pkt_4 F)
  ( parametric->/c [a] (-> (-> (-> a a) a) a))
  (lambda (a) (F (F a)))
  )