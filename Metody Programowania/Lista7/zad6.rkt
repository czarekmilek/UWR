#lang racket

(define (my-foldr f x xs)
  (if (null? xs)
      x
      (f (car xs) (my-foldr f x (cdr xs)))))

(define/contract (my-foldr-con f x xs)
  ;( parametric->/c [a b] (-> (-> a b b) b ( listof a) b))
  ( parametric->/c [a] (-> (-> a a a) a ( listof a) a))
  (if (null? xs)
      x
      (f (car xs) (my-foldr f x (cdr xs)))))


;(( 'a 'b - > 'b) 'b ( Listof 'a) -> 'b)
(define (fold-right f acc xs)
  (if (empty? xs)
      acc
      (f (first xs) (fold-right f (first xs) (rest xs)) )
      )
  )

;Błędna implementacja fold-right
(define/contract (fold-right-con f acc xs)
  ;( parametric->/c [a b] (-> (-> a b b) b ( listof a) b))
  ( parametric->/c [a] (-> (-> a a a) a ( listof a) a))
  (if (empty? xs)
      acc
      (f (first xs) (fold-right f (first xs) (rest xs)) )
      )
  )


(fold-right cons '() (list 1 2 3))
(foldr cons '() (list 1 2 3))
;dla procedury cons wynik nie jest taki sam
