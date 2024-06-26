#lang racket
(require rackunit)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (flatten t)
  (define (flatten-acc t acc)
    (cond [(leaf? t) acc]
          [(node? t) (flatten-acc (node-l t)
             (cons (node-elem t) (flatten-acc (node-r t) acc)))]))
  (flatten-acc t '()))



(define tree1 (node (node (leaf) 3 (leaf)) 1 (node (leaf) 4 (leaf))))
(define tree2 (node (node (leaf) 2 (node (leaf) 3 (leaf))) 1 (node (leaf) 4 (leaf))))
(define tree3 (node (node (leaf) 3 (leaf)) 3 (node (leaf) 3 (leaf))))
(define tree4 (leaf))

(check-equal? (flatten tree1) '(3 1 4))
(check-equal? (flatten tree2) '(2 3 1 4))
(check-equal? (flatten tree3) '(3 3 3))
(check-equal? (flatten tree4) '())
