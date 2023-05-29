#lang racket

(define (negatives n)
  (reverse (build-list n (lambda (x) (- x n)))))

(define (reciprocals n)
  (build-list n (lambda (x) (/ 1 (+ x 1)))))

(define (evens n)
  (build-list n (lambda (x) (* 2 (+ x 1)))))

(define (identityM n)
  (build-list n
              (lambda (i)
                (build-list n
                            (lambda (j)
                              (if (= i j) 1 0))))))


