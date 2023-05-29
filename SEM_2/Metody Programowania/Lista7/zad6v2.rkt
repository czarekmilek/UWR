#lang plait 

(define (my-foldr f x xs)
  (if (empty? xs)
      x
      (f (first xs) (my-foldr f x (rest xs)))))

(define (fold-right f acc xs)
  (if (empty? xs)
      acc
      (f (first xs) (fold-right f (first xs) (rest xs)) )
      )
  )



(define my-list (list 1 2 3 4 5))

;(define pairs (fold-right create-pair (list) my-list))
(define ap (fold-right + 1 my-list))


;_a istnieje taki typ spełniający
; a dla każdego

;(fold-right cons '() (list 1 2 3))
;(foldr cons '() (list 1 2 3))
;dla procedury cons wynik nie jest taki sam

;(( ' a 'a - > 'a) 'a ( Listof 'a) -> 'a)
;zmiana typu powoduje błąd, ponieważ funkcja f musiałaby być, która bierze 'a i 'a oraz zwraca 'a, ograniczamy się tylko do tego typu

