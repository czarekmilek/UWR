#lang racket

(require rackunit)

(define (my-compose f g)
  (lambda (x)
    (f (g x))))

; procedura square oblicza kwadrat swojego argumentu
(define (square x)
  (* x x))

; procedura inc zwiększa wartość argumentu o 1
(define (inc x)
  (+ x 1))


(define square-inc (my-compose square inc))
(define inc-square (my-compose inc square))

( (my-compose square inc) 5 )
; równoważne z (square (inc 5))
; równoważne z (square 6)
; wynik: 36

( (my-compose inc square) 5 )
; równoważne z (inc (square 5))
; równoważne z (inc 25)
; wynik: 26

(check-equal? ( (my-compose square inc) 5 ) (square-inc 5))
(check-equal? ( (my-compose inc square) 5 ) (inc-square 5))
