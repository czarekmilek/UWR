#lang racket

; zwraca #t jeśli element należy do zbioru, #f w przeciwnym wypadku.
(define (elem? a s)
  (cond ((empty? s) #f)
        ((equal? a (car s)) #t)
        (else (elem? a (cdr s)))))


; Zdefiniowanie zbioru pustego.
(define empty-set '())


; Zdefiniowanie zbioru jednoelementowego.
(define (singleton a)
  (list a))


; Sprawdzenie czy element należy do zbioru.
(define (in a s)
  (elem? a s))


; Suma zbiorów.
(define (union s t)
  (cond ((empty? s) t)
        ((in (car s) t) (union (cdr s) t))
        (else (cons (car s) (union (cdr s) t)))))


; Przecięcie zbiorów.
(define (intersect s t)
  (cond ((empty? s) '())
        ((in (car s) t) (cons (car s) (intersect (cdr s) t)))
        (else (intersect (cdr s) t))))