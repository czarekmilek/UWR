#lang plait

(define-type (RoseTree 'a)
  (leaf [elem : 'a])
  (node [children : (Listof (RoseTree 'a))]))


(define example-rose
  (node (list (leaf "A")
              (node (list (leaf "B")
                          (leaf "C")
                          (leaf "C2")))
              (leaf "D")
              (node (list (node (list (leaf "E")
                                       (leaf "F")))
                          (leaf "G"))))))



(define (show-rose [r : (RoseTree 'a)]) : (Listof 'a)
  (local
    ;funkcja do łączenia listy list w jedą listę
    [(define (list-flatten [l : (Listof (Listof 'a))]) : (Listof 'a)
       ;Funkcja ta wykorzystuje rekursję i append do połączenia list w jedną
       (if (empty? l)
           '()
           (append (first l) (list-flatten (rest l)))))]

  (cond
    ;jak dotrzemy do liścia zwracamy listę jednoelementową
    [(leaf? r) (list (leaf-elem r))]
    [else
     ; wpp robimy jedną listę z połączonych elementów od lewej strony:
     ;Wywołujemy rekurencyjnie funkcję show-rose na każdym dziecku węzła r przy użyciu map.
     ;Wyniki te przekazujemy do list-flatten, aby połączyć je w jedną listę. 
     (list-flatten (map show-rose (node-children r)))])))


(show-rose example-rose)

;                  node
;     /         /       \        \
;   /         /           \        \
;leaf      node          leaf      node
; "A"     /   |  \        "D"      /   \
;       leaf leaf leaf           node   leaf
;        "B"  "C"  "C2"         /    \   "G"
;                              leaf leaf
;                               "E"  "F"


