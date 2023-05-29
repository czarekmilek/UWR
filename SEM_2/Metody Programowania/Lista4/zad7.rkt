#lang racket
(require rackunit)

(define (empty-queue)
  (cons '() '())) ; pusta kolejka, para (pierwsza lista, druga lista)

(define (empty? q)
  (null? (car q))) ; kolejka jest pusta tylko wtedy, gdy pierwsza lista jest pusta

(define (push-back x q)
  (if (empty? q)
      (cons (list x) '())
      (cons (car q) (cons (cons x '()) (cdr q))))) ; dodaj element na przód drugiej listy

(define (front q)
  (if (empty? q)
      (error "kolejka jest pusta")
      (car (car q)))) ; pierwszy element kolejki to pierwszy element pierwszej listy

(define (pop q)
  (if (empty? q)
      (error "kolejka jest pusta")
      (let ((f (car (car q))) ; zdejmij element z przodu kolejki
            (r (cdr (car q))))
        (if (null? r) ; jeśli pierwsza lista jest pusta
            (cons (reverse (cdr (cdr q))) '()) ; zastąp ją odwróconą drugą listą
            (cons r (cdr q))) ; w przeciwnym przypadku, usuń tylko pierwszy element pierwszej listy
        f))) ; zwróć zdejmowany element


;; testy dla empty-queue
(check-equal? (empty-queue) '(() . ()))
(check-equal? (empty? (empty-queue)) #t)

;; testy dla push-back
(check-equal? (push-back 1 (empty-queue)) '((1)))
(check-equal? (push-back 2 (cons '(1) '((2)))) '((1) (2) (2)))
(check-equal? (push-back 3 (cons '(1 2) '((3)))) '((1 2) (3) (3)))

;; testy dla front
(check-equal? (front (cons '(1) '())) 1)
(check-equal? (front (cons '(1) '((2)))) 1)

;; testy dla popZ
(check-equal? (pop (cons '(1) '((2)))) 1)
(check-equal? (pop (cons '(1 2) '((3)))) 1)
(check-equal? (pop (empty-queue)) (error "kolejka jest pusta"))


