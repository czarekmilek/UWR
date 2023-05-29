#lang racket

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

; drzewo to:
; - albo (leaf)
; - albo (node l elem r), gdzie l i r to drzewa

(define (tree? x)
  (cond [(leaf? x) #t]
        [(node? x) (and (tree? (node-l x))
                        (tree? (node-r x)))]
        [else #f]))

; konstruktor sprawdzający rodzaje wartości pól
; uwaga: przegląda rekurencyjnie poddrzewa
(define (tree-node l elem r)
  (if (and (tree? l) (tree? r) (number? elem))
      (node l elem r)
      (error "nieprawidłowe pola węzła")))

(define (tree-alt? x)
  (or (leaf? x)
      (and (node? x)
           (tree-alt? (node-l x))
           (tree-alt? (node-r x)))))

; drzewo binarnych przeszukiwań (BST) to drzewo takie, że:
; jeśli jest węzłem, to elementy lewego poddrzewa
; są mniejsze niż element węzła, zaś elementy prawego
; poddrzewa są większe (lub równe) niż element węzła

; stosujemy "lub równe" jeśli chcemy mieć wielokrotne
; wystąpenia wartości w drzewie

(define (find-bst x t)
  (cond [(leaf? t) #f]
        [(node? t)
         (cond [(= x (node-elem t)) #t]
               [(< x (node-elem t))
                (find-bst x (node-l t))]
               [else
                (find-bst x (node-r t))])]))

(define (insert-bst x t)
  (cond [(leaf? t) (node (leaf) x (leaf))]
        [(node? t)
         (cond [(= x (node-elem t)) t]
                [(< x (node-elem t))
                 (node (insert-bst x (node-l t))
                       (node-elem t)
                       (node-r t))]
                [else
                 (node (node-l t)
                       (node-elem t)
                       (insert-bst x (node-r t)))])]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (bst? t)
  (define (bst-helper t min max)
    (cond [(leaf? t) #t]
          [(and (<= min (node-elem t))
                (< (node-elem t) max))
           (and (bst-helper (node-l t) min (node-elem t))
                (bst-helper (node-r t) (node-elem t) max))]
          [else #f]))
  (bst-helper t -inf.0 +inf.0))

(define (sum-paths t)
  (define (sum-paths-helper t parent-sum)
    (cond [(leaf? t) (leaf)]
          [(node? t)
           (let ([new-sum (+ (node-elem t) parent-sum)])
             (node (sum-paths-helper (node-l t) new-sum)
                   new-sum
                   (sum-paths-helper (node-r t) new-sum)))]))
  (sum-paths-helper t 0))



(define t
  (node (node (node (leaf) 3 (leaf)) 5 (node (leaf) 7 (leaf))) 10 (node (leaf) 15 (node (leaf) 20 (leaf)))))
;     10
;    /  \
;   5    15
;  / \     \
; 3   7     20
(bst? t)
;#t


(define t2
  (node (node (node (leaf) 333 (leaf)) 5 (node (leaf) 7 (leaf))) 10 (node (leaf) 15 (node (leaf) 20 (leaf)))))
;     10
;    /  \
;   5    15
;  / \     \
; 333   7     20
(bst? t2)
;#f

(sum-paths t)
;(node
; (node (node (leaf) 18 (leaf)) 15 (node (leaf) 22 (leaf)))
; 10
; (node (leaf) 25 (node (leaf) 45 (leaf))))
