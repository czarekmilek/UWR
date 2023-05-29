#lang racket
(define (suffixes xs)
  (if (null? xs)
      (list '())
      (cons xs (suffixes (cdr xs)))))

(suffixes (list 1 2 3 4))
;'((1 2 3 4) (2 3 4) (3 4) (4) ())
(suffixes (list "a" "b" "c"))
;'(("a" "b" "c") ("b" "c") ("c") ())
(suffixes (list))
;'(())

