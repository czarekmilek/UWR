#lang plait

(define (append xs ys)
  (if (empty? xs)
      ys
      (cons (first xs) (append (rest xs) ys))))

(define l1 (list 1 2 3 4))
(define l2 (list 5 6 7 8))

(define (zloz f g) (lambda (x) (f (g x))))


(define (my-map f xs)
  (if (empty? xs)
      empty
      (cons (f (first xs)) (map f (rest xs)))))
