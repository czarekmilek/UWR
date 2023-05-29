#lang racket
(require rackunit)

 
(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

(define (fold-tree f acc t)
  (cond [(leaf? t) acc]
        [(node? t)
         (f (node-elem t)
            (fold-tree f acc (node-l t))
            (fold-tree f acc (node-r t)))]))


(define (tree-sum t)
  (fold-tree + 0 t))

(define (tree-flip t)
  (fold-tree (lambda (e l r) (node r e l))
             (leaf)
             t))

(define (tree-height t)
  (cond [(leaf? t) 0]
        [(node? t)
         (add1 (max (tree-height (node-l t))
                    (tree-height (node-r t))))]))


; "l" i "r" są listami elementów (podlistami),
; które reprezentują lewe i prawe poddrzewa danego węzła,
; a "e" to wartość samego węzła.

(define (tree-span t)
  (fold-tree (lambda (e l r)
               (cond [(leaf? l) (cons e (cons e r))]
                     [(leaf? r) (cons e (cons l e))]
                     [else (cons (min e (car l)) (max e (car r)))]))
             (cons +inf.0 -inf.0)
             t))

;latwiejsza wersja
(define (tree-span2 t)
  (cons (fold-tree min +inf.0 t) (fold-tree max -inf.0 t)))



(define (flatten t)
  (fold-tree (lambda (e l r) (append l (cons e r)))
             '()
             t))


; testy dla funkcji tree-sum
(define t1 (node (node (leaf) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(define t2 (node (node (leaf) -5 (leaf)) -3 (node (leaf) -1 (leaf))))

(check-equal? (tree-sum (leaf)) 0)
(check-equal? (tree-sum t1) 9)
(check-equal? (tree-sum t2) -9)

; testy dla funkcji tree-flip
(define t3 (node (node (leaf) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(define t4 (node (node (leaf) 4 (leaf)) 3 (node (leaf) 2 (leaf))))

(check-equal? (tree-flip (leaf)) (leaf))
(check-equal? (tree-flip t3) t4)

; testy dla funkcji tree-height
(define t5 (node (node (leaf) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(define t6 (node (node (leaf) 2 (leaf)) 3 (leaf)))

(check-equal? (tree-height (leaf)) 0)
(check-equal? (tree-height t5) 2)
(check-equal? (tree-height t6) 2)

; testy dla funkcji tree-span
(define t7 (node (node (leaf) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(define t8 (node (node (leaf) -5 (leaf)) -3 (node (leaf) -1 (leaf))))

(check-equal? (tree-span (leaf)) (cons +inf.0 -inf.0))
(check-equal? (tree-span t7) (cons 2.0 4.0))
(check-equal? (tree-span t8) (cons -5.0 -1.0))
(tree-span2 t1)

; testy dla funkcji flatten
(define t9 (node (node (leaf) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(define t10 (node (node (node (leaf) 2 (leaf)) 3 (leaf)) 4 (leaf)))
(define t11 (node (node (node (leaf) 7 (leaf)) 9 (node (leaf) 11 (leaf))) 13 (node (node (leaf) 15 (leaf)) 17 (node (leaf) 19 (leaf)))))

(check-equal? (flatten (leaf)) '())
(check-equal? (flatten t9) '(2 3 4))
(check-equal? (flatten t10) '(2 3 4))
(check-equal? (flatten t11) '(7 9 11 13 15 17 19))


