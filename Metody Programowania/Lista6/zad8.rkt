#lang plait

(define (sorted? xs)
  (cond
    [(empty? xs) #t]
    [(empty? (rest xs)) #t]
    [else
     (and (<= (first xs) (second xs))
          (sorted? (rest xs)))]))

(define (insert x xs)
  (cond
    [(empty? xs) (list x)]
    [else
     (if (< x (first xs))
         (cons x xs)
         (cons (first xs) (insert x (rest xs))))]))


(sorted? '()) ; => #t
(sorted? '(1 2 3 4 5)) ; => #t
(sorted? '(1 2 3 5 4)) ; => #f
(sorted? '(5 4 3 2 1)) ; => #f

(insert 3 '()) ; => '(3)
(insert 3 '(1 2 4)) ; => '(1 2 3 4)
(insert 3 '(1 2 3 4)) ; => '(1 2 3 3 4)
(insert 3 '(3 4 5 6)) ; => '(3 3 4 5 6)

(sorted? (insert 3 '())) ; => #t
(sorted? (insert 3 '(1 2 4))) ; => #t
(sorted? (insert 3 '(1 2 3 4))) ; => #t
(sorted? (insert 3 '(3 4 5 6))) ; => #t
