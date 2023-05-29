#lang racket

(define (suffixes lst acc)
    (if (null? lst)
        acc
        (suffixes (cdr lst) (cons lst acc))))

(define/contract (suffixes2 lst acc)
  [parametric->/c [a] (-> (listof a) (listof a) (listof (listof a)))]
  (if (null? lst)
        acc
        (suffixes2 (cdr lst) (cons lst acc))))



;; przykładowe użycie
(time (suffixes (range 3333) empty) (void))
(time (suffixes2 (range 3333) empty) (void))