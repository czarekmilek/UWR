#lang racket
(define (suma-kwadratow a b c)
  (cond [(and (<= a b) (<= b c)) (+ (* b b) (* c c))]
        [(and (<= b c) (<= c a)) (+ (* c c) (* a a))]
        [(and (<= c a) (<= a b)) (+ (* a a) (* b b))]
        [else -1]))


(require rackunit)

(check-equal? (suma-kwadratow 3 4 5) 41)
(check-equal? (suma-kwadratow 2 2 2) 8)
(check-equal? (suma-kwadratow 1 2 3) 13)
(check-equal? (suma-kwadratow 5 5 5) 50)
(check-equal? (suma-kwadratow 1 2 2) 8)
(check-equal? (suma-kwadratow -2 4 -3) 20)
(check-equal? (suma-kwadratow 100 100 3) 20000)


