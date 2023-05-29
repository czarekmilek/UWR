#lang racket

(require rackunit)

(define (my-foldl f x xs)
  (define (it xs acc)
    (if (null? xs)
        acc
        (it (cdr xs) (f (car xs) acc))))
  (it xs x))

(define (product lst)
  (if (null? lst)
      0
      (my-foldl * 1 lst)))

(define (product2 lst)
      (my-foldl * 1 lst))


(check-equal? (product null) 0)
(check-equal? (product2 null) 1)
(check-equal? (product (list 1 2 3 4)) 24)
(check-equal? (product (list 1 2 3 4 5 6 7 8 9)) 362880)
(check-equal? (product (list -1 -2 -3 4 5)) -120)
