#lang racket


(define (list->llist xs)
  (lambda (ys)
    (append xs ys)))

(define (llist->list f)
  (f '()))

(define llist-null
  (lambda (xs)
    xs))

(define (llist-singleton x)
  (list->llist (list x)))

(define (llist-append f g)
  (lambda (ys)
    (append (f ys) (g ys))))



(define lst (list->llist '(1 2 3)))
(llist->list lst)
;'(1 2 3)

(define lst2 (llist-singleton 4))
(llist->list lst2)
;'(4)

(define lst3 (llist-append lst lst2))
(llist->list lst3)
;'(1 2 3 4)

(define lst4 (llist-append lst2 lst))
(llist->list lst4)
;'(4 1 2 3)


(define (foldr-llist-reverse func acc lst)
  (foldr (lambda (x y) (llist-append x y)) (llist-singleton acc) lst) func)

(foldr-llist-reverse (lambda (x y) (+ x y)) 0 '(1 2 3))
(foldr-llist-reverse (lambda (x y) (cons x y)) '() '(1 2 3))
(foldr-llist-reverse (lambda (x y) (list x y)) '() '(1 2 3))
(foldr-llist-reverse (lambda (x y) (string-append x " " y)) "" '("foo" "bar" "baz"))



