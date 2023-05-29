#lang racket
(require rackunit)

(define (split xs)
  (let loop ((xs xs) (ys '()) (zs '()))
    (cond
      ((null? xs) (cons ys zs))
      ((null? (cdr xs)) (cons (cons (car xs) ys) zs))
      (else (loop (cddr xs) (cons (car xs) ys) (cons (cadr xs) zs))))))

(define (merge xs ys)
  (cond
    ((null? xs) ys)
    ((null? ys) xs)
    ((< (car xs) (car ys)) (cons (car xs) (merge (cdr xs) ys)))
    (else (cons (car ys) (merge xs (cdr ys))))))

(define (merge-sort xs)
  (cond
    ((null? xs) '())
    ((null? (cdr xs)) xs)
    (else
      (let ((s (split xs)))
        (merge (merge-sort (car s)) (merge-sort (cdr s)))))))


(check-equal? (merge-sort (list 12 3 4 8 0 98 2)) (list 0 2 3 4 8 12 98))
(check-equal? (merge-sort (list 9 8 7 6 5 4 3 2 1)) (list 1 2 3 4 5 6 7 8 9))
(check-equal? (merge-sort (list -5 -6 -7 -122 0 23 49)) (list -122 -7 -6 -5 0 23 49))
(check-equal? (merge-sort null) '())
