#lang racket
(define (select xs)
  (cond ((null? xs) '())
        (else
         (let loop ((min (car xs)) (rest (cdr xs)) (acc '()))
           (cond ((null? rest) (cons min acc))
                 ((< (car rest) min)
                  (loop (car rest) (cdr rest) (cons min acc)))
                 (else
                  (loop min (cdr rest) (cons (car rest) acc))))))))

(define (selection-sort xs)
  (cond ((null? xs) '())
        (else
         (let ((min-pair (select xs)))
           (cons (car min-pair) (selection-sort (cdr min-pair)))))))


(select (list 4 3 1 2 5))
;'(1 5 2 3 4)
(select (list 787 66 145 22 546))
;'(22 546 66 145 787)
(select (list 1))
;'(1)
(select null)
;'()
(selection-sort (list 1 5 0 7 1 4 1 0))
;'(0 0 1 1 1 4 5 7)
(selection-sort (list -1 5 0 -7 1 4.4 1.123 0))
;'(0 0 1 1 1 4 5 7)
(selection-sort (list 1))
;'(1)
(selection-sort '())
;'()