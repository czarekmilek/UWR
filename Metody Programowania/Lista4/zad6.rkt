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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Jeśli dany węzeł jest liściem, funkcja "delete" zwraca ten sam liść,
;ponieważ nie ma w nim węzła o wartości "x" do usunięcia.

;Jeśli dany węzeł jest węzłem, funkcja "delete" używa
;kolejnej konstrukcji "cond" do sprawdzenia, czy wartość "x" jest równa wartości węzła.

;Jeśli wartość "x" jest równa wartości węzła, funkcja "delete" sprawdza,
;czy lewe poddrzewo lub prawe poddrzewo jest liściem,
;a następnie zwraca odpowiednio lewe lub prawe poddrzewo jako nowe drzewo.

;W przeciwnym przypadku funkcja znajduje najmniejszy węzeł w prawym
;poddrzewie za pomocą funkcji pomocniczej "find-min-node", a następnie
;rekurencyjnie wywołuje funkcję "delete" na tym węźle, aby usunąć go z drzewa.

;Następnie funkcja tworzy nowe drzewo, w którym najmniejszy węzeł jest usuwany,
;a jego wartość zostaje zastąpiona przez wartość usuwanego węzła,
;a lewe i prawe poddrzewa są odpowiednio ustawiane.

;Jeśli wartość "x" jest mniejsza niż wartość węzła,
;funkcja "delete" rekurencyjnie wywołuje się na lewym poddrzewie.

;Jeśli wartość "x" jest większa niż wartość węzła,
;funkcja "delete" rekurencyjnie wywołuje się na prawym poddrzewie.

(define (delete x t)
  (cond [(leaf? t) t]
        [(node? t)
         (cond [(= x (node-elem t))
                (cond [(leaf? (node-l t)) (node-r t)]
                      [(leaf? (node-r t)) (node-l t)]
                      [else
                       (let* [(min-node (find-min-node (node-r t)))
                              (new-r (delete (node-elem min-node) (node-r t)))
                              (new-l (node-l t))]
                         (node new-l (node-elem min-node) new-r))])]
               [(< x (node-elem t))
                (node (delete x (node-l t)) (node-elem t) (node-r t))]
               [else
                (node (node-l t) (node-elem t) (delete x (node-r t)))])]))

(define (find-min-node t)
  (if (leaf? t) t
      (find-min-node (node-l t))))

; Przykład 1:
; Usunięcie elementu, który jest liściem
(define tree1 (node (node (leaf) 1 (leaf)) 2 (node (leaf) 3 (leaf))))
(check-equal? (delete 1 tree1) (node (leaf) 2 (node (leaf) 3 (leaf))))


; Przykład 2:
; Usunięcie elementu, który ma tylko lewe poddrzewo
(define tree2 (node (node (node (leaf) 1 (leaf)) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(check-equal? (delete 1 tree2) (node (node (leaf) 2 (leaf)) 3 (node (leaf) 4 (leaf))))


; Przykład 3:
; Usunięcie elementu, który ma tylko prawe poddrzewo
(define tree3 (node (node (node (leaf) 1 (leaf)) 2 (leaf)) 3 (node (leaf) 4 (leaf))))
(check-equal? (delete 4 tree3) (node (node (node (leaf) 1 (leaf)) 2 (leaf)) 3 (leaf)))


; Przykład 4:
; Usunięcie korzenia z drzewa z tylko jednym elementem
(define tree4 (node (leaf) 1 (leaf)))
(check-equal? (delete 1 tree4) (leaf))


; Przykład 5:
; Usunięcie elementu, który nie istnieje w drzewie
(define tree5 (node (node (leaf) 1 (leaf)) 2 (node (leaf) 3 (leaf))))
(check-equal? (delete 4 tree5) tree5)
