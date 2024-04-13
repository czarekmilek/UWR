#lang racket

( define ( foldr-reverse xs )
( foldr ( lambda ( y ys ) ( append ys ( list y ) ) ) null xs ) )

;; Funkcja rekurencyjna do odwracania listy bez tworzenia dodatkowych obiektów
(define (reverse-list-rec lst)
  (define (reverse-helper lst acc)
    (if (null? lst)
        acc
        (reverse-helper (cdr lst) (cons (car lst) acc))))
  (reverse-helper lst '()))

(define (my-foldl f x xs)
  (define (it xs acc)
    (if (null? xs)
        acc
        (it (cdr xs) (f (car xs) acc))))
  (it xs x))


;; Funkcja foldl do odwracania listy
(define (reverse-list-foldl lst)
  (my-foldl (lambda (x acc) (cons x acc)) '() lst))


(foldr-reverse (list 1 2 3 4 5))
(reverse-list-rec (list 1 2 3 4 5 6 7 8))
(reverse-list-foldl (list 1 2 3 4 5))


(define (append-test lhs rhs)
  (if (empty? lhs)
      rhs
      (cons (first lhs) (append-test (rest lhs) rhs))))