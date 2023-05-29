#lang plait

(define-type 23Tree
  [leaf (val : 'a)]
  [node2 (val : 'a) (left : 23Tree) (right : 23Tree)]
  [node3  (val1 : 'a)(val2 : 'a) (left : 23Tree) (mid : 23Tree) (right : 23Tree)]
  )


(define (height t)
  (cond
   ((leaf? t) 1)
   ((node2? t) (max (+ 1 (height (node2-left t)))  (+ 1 (height (node2-right t)))))
   ((node3? t)
    (max 
      (+ 1 (height (node3-left t)))
      (max 
        (+ 1 (height (node3-mid t)))
        (+ 1 (height (node3-right t))))
      )
    )
   )
  )


(define (balanced? t)
  (cond
    ;sam liść jest zbalansowany
    ((leaf? t) #t)
    ;jeżeli główny węzeł jest zbalansowany oraz wszystkie podwęzły
    ((node2? t) (and (= (height (node2-left t)) (height (node2-right t)))
                     (balanced? (node2-left t))
                     (balanced? (node2-right t))
                     ))
    ;jeżeli główny węzeł jest zbalansowany oraz wszystkie podwęzły
    ((node3? t) (and (and (= (height (node3-left t)) (height (node3-mid t))) (= (height (node3-right t)) (height (node3-mid t))) )
                     (balanced? (node3-left t))
                     (balanced? (node3-mid t))
                     (balanced? (node3-right t))
                      )
    )
  ))



(define (ordered? t upper-limit lower-limit)
  (cond
    ;liść ma zachowany porządek
    ((leaf? t) #t)
    ; w przypadku węzła z dwoma dziećmi
    ((node2? t) (and
                 ;wartości muszą być w przedziale
                  (> (node2-val t) lower-limit)
                  (< (node2-val t) upper-limit)
                  ;uszeregowane również muszą być dzieci
                  (ordered? (node2-left t) (node2-val t) lower-limit)
                  (ordered? (node2-right t) upper-limit (node2-val t))))
    ; w przypadku węzła z trzema dziećmi
    ((node3? t)
      (and
       ;węzły muszą być w przedziale z funkcji, jak i między sobą
        (> (node3-val1 t) lower-limit)
        (< (node3-val1 t) upper-limit)
        (> (node3-val2 t) lower-limit)
        (< (node3-val2 t) upper-limit)
        (< (node3-val1 t) (node3-val2 t))
        ;przedział lewego poddrzewa jest ustalony na podstawie lewego elementu 
        (ordered? (node3-left t) (node3-val1 t) lower-limit)
        ;środkowy na podstawie obu elementów
        (ordered? (node3-mid t) (node3-val2 t) (node3-val1 t))
        ;prawy na podstawie prawego elementu
        (ordered? (node3-right t) upper-limit (node3-val2 t))
      )
    )
  )
)

;własnością typu jestem w stanie wymusić kształt drzewa, z czego się składa (typ 'a) i jaka jest jego struktura (leaf, node1, node2)
;natomiast jego właściwości są determinowane przez predykat


;predykat
(define (is23Tree? t)
  (and (balanced? t) (ordered? t -inf.0 +inf.0))
  )

(define tree3 (node2
               4
               (node3 3 2 (leaf 1) (leaf 2) (leaf 3))
               (node3 5 6 (leaf 4) (leaf 5) (leaf 6))))

(ordered? tree3 -inf.0 +inf.0) ;f
(is23Tree? tree3) ;f

(define balanced-tree
  (node3
    4 7
    (node2 2 (leaf 1) (leaf 3))
    (node2 5 (leaf 4) (leaf 6))
    (node2 9 (leaf 8) (leaf 10))
  )
)

(define unbalanced-tree
  (node3
    4 7
    (node2 2 (leaf 1) (leaf 3))
    (node2 5 (leaf 4) (leaf 6))
    (node2 8 (leaf 7) (node2 9 (leaf 10) (leaf 11)) )
  )
)

(balanced? balanced-tree)    ; #t
(balanced? unbalanced-tree)  ; #f

(define tree1 (leaf 5))
(is23Tree? tree1) ; #t

(define tree2 (node2 5 (leaf 7) (leaf 2)))
(is23Tree? tree2) ; #f

(define tree33 (node2 2 (node2 3 (leaf 4) (leaf 5)) (leaf 6)))
(is23Tree? tree33) ; #f

(define tree4 (node3 4 7 (node2 2 (leaf 1) (leaf 3)) (node2 5 (leaf 4) (leaf 6)) (node2 8 (leaf 7) (leaf 9))))
(is23Tree? tree4) ; #t

(define tree5 (node3 4 7 (node2 2 (leaf 1) (leaf 3)) (node2 5 (leaf 4) (leaf 6)) (node2 8 (leaf 7) (node2 9 (leaf 10) (leaf 11)) )))
(is23Tree? tree5) ; #f

(define tree6 (node2 4 (node3 5 6 (leaf 1) (leaf 2) (leaf 3)) (node3 7 8 (leaf 4) (leaf 5) (leaf 6))))
(is23Tree? tree6) ; #f
