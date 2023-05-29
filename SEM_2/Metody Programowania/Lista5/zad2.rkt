#lang plait

;Wywolanie funkcji
(define (apply f x) (f x))
;Przyjmuje funkcję f i argument x i stosuje wykonuje f(x), zwracając wynik.

;Zlozenie funkcji
(define (compose f g) (lambda (x) (f (g x))))
;Bierze dwie funkcje f i g i zwraca nową funkcję,
;która stosuje jedną z nich, a następnie stosuje ją jako argument drugiej.

;Odwrocenie argumentow funkcji
(define (flip f) (lambda (x y) (f y x)))
;Bierze funkcję f i zwraca nową funkcję,
;która przyjmuje argumenty w odwrotnej kolejności,
;tj. odwróć f przyjmuje argumenty jako y, a następnie x zamiast x, a następnie y:
; f(x y) -> f(y x)

;Currying - rozwijanie funkcji
(define (curry f) (lambda (x) (lambda (y) (f x y))))
;Bierze funkcję f i zwraca nową funkcję,
;która pobiera argumenty jeden po drugim, zwracając nową funkcję na każdym kroku,
;tj. curry f przyjmuje argument x i zwraca nową funkcję, która przyjmuje argument y i stosuje f x y.






(define f ( curry compose ))
;Rozbicie funkcji compose na kolejne funkcje: (('_a -> '_b) -> (('_c -> '_a) -> ('_c -> '_b)))

(define g (( curry compose ) ( curry compose ) ))
(define h (( curry compose ) ( curry apply ) ))
(define i (( curry apply ) ( curry compose ) ))
(define j ( compose curry flip ))