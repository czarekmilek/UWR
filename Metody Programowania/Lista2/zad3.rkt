#lang racket
(require rackunit)

(define-struct matrix (a b c d))

(define (matrix-mult m n)
  (let ((a1 (matrix-a m)) (b1 (matrix-b m)) (c1 (matrix-c m)) (d1 (matrix-d m))
        (a2 (matrix-a n)) (b2 (matrix-b n)) (c2 (matrix-c n)) (d2 (matrix-d n)))
    (make-matrix (+ (* a1 a2) (* b1 c2)) (+ (* a1 b2) (* b1 d2))
                 (+ (* c1 a2) (* d1 c2)) (+ (* c1 b2) (* d1 d2)))))

(define matrix-id (make-matrix 1 0 0 1))

(define (matrix-expt m k)
  (cond ((= k 0) matrix-id)
        ((= k 1) m)
        ((even? k) (matrix-expt (matrix-mult m m) (/ k 2)))
        (else (matrix-mult m (matrix-expt m (- k 1))))))


(check-equal? (matrix-mult (make-matrix 0 0 0 0) (make-matrix 5 6 7 8)) (make-matrix 0 0 0 0))
(check-equal? (matrix-expt (make-matrix 3 2 4 2) 2) (make-matrix 9 4 16 4))

(define (fib-matrix k)
  (let ((m (make-matrix 1 1 1 0)))
    (matrix-a (matrix-expt m (- k 1)))))


(check-equal? (fib-matrix 2) 1)
(check-equal? (fib-matrix 5) 5)
(check-equal? (fib-matrix 13) 233)
(check-equal? (fib-matrix 20) 6765)


;Zadanie 4
(define (matrix-expt-fast m k)
  (cond ((= k 0) matrix-id)
        ((even? k) (let ((mk/2 (matrix-expt-fast m (/ k 2))))
                     (matrix-mult mk/2 mk/2)))
        (else (matrix-mult m (matrix-expt-fast m (- k 1))))))

(define (fib-fast k)
  (let ((m (make-matrix 1 1 1 0)))
    (matrix-a (matrix-expt-fast m (- k 1)))))


(check-equal? (fib-fast 2) 1)
(check-equal? (fib-fast 5) 5)
(check-equal? (fib-fast 13) 233)
(check-equal? (fib-fast 20) 6765)

