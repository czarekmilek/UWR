#lang racket
(require rackunit)

; rekurencyjna implementacja ciągu Fibonacciego
(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1))
         (fib (- n 2)))))


; iteracyjna implementacja ciągu Fibonacciego
(define (fib-iter n)
  (define (iter i prev curr)
    (if (= i (+ n 1))
        curr
        (iter (+ i 1) curr (+ prev curr))))
  (if (= n 0)
      0
      (if (< n 2)
          1
          (iter 2 0 1))))


(check-equal? (fib 2) 1)
(check-equal? (fib 5) 5)
(check-equal? (fib 13) 233)
(check-equal? (fib 20) 6765)


(check-equal? (fib-iter 2) 1)
(check-equal? (fib-iter 5) 5)
(check-equal? (fib-iter 13) 233)
(check-equal? (fib-iter 20) 6765)