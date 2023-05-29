#lang racket
(define (elem? x xs)
  (cond ((null? xs) #f)
        ((equal? x (car xs)) #t)
        (else (elem? x (cdr xs)))))


(elem? 2 (list 1 2 3))
;#t
(elem? 4 (list 1 2 3))
;#f
(elem? 'a (list 'b 'c 'd 'a))
;#t
(elem? "hello" (list "world" "hello" "there"))
;#t
(elem? 5 (list))
;#f