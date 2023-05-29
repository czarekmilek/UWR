#lang racket

(define (list->llist xs)
  (define (f arg)
    (cond ((null? arg) xs)
          (else (cons (car arg) (f (cdr arg)))))) 
  f)

(define (llist->list f)
  (f '()))

(define llist-null (lambda (arg) '()))

(define (llist-singleton x)
  (define (f arg)
    (cond ((null? arg) (cons x '()))
          (else (cons (car arg) (f (cdr arg)))))) 
  f)

(define (llist-append f g)
  (lambda (lst)
    (append (f lst) (g lst))))




(define xs (list->llist '(1 2 )))
(define ys (list->llist '(4 5)))

(llist->list xs) ; => '(1 2 3)
(llist->list ys) ; => '(4 5)

(define zs (llist-append xs ys))
(llist->list zs) ; => '(1 2 3 4 5)

(define ws (llist-singleton 0))
(llist->list ws) ; => '(0)

(define empty llist-null)
(llist->list empty) ; => '()
