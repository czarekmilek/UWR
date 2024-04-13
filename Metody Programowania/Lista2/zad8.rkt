#lang racket
(define (sorted? xs)
  (cond
    ((empty? xs) #t)                  ; pusta lista jest posortowana
    ((empty? (rest xs)) #t)           ; lista jednoelementowa jest posortowana
    ((> (first xs) (second xs)) #f)  ; jeśli pierwszy element jest większy od drugiego, lista nie jest posortowana
    (else (sorted? (rest xs)))))      ; w przeciwnym przypadku rekurencyjnie sprawdź pozostałe elementy

(sorted? '(1 2 3 4 5))       ; zwróci #t, ponieważ lista jest posortowana niemalejąco
(sorted? '(1 3 2 4 5))       ; zwróci #f, ponieważ lista nie jest posortowana niemalejąco
(sorted? '(1 1 2 2 3 3))     ; zwróci #t, ponieważ lista jest posortowana niemalejąco (mogą wystąpić powtarzające się elementy)
(sorted? '(5 4 3 2 1))       ; zwróci #f, ponieważ lista nie jest posortowana niemalejąco
(sorted? '(1))               ; zwróci #t, ponieważ lista jednoelementowa jest posortowana niemalejąco
(sorted? '())                ; zwróci #t, ponieważ pusta lista jest posortowana niemalejąco
(sorted? '(1.1 1.2 1.3 1.3)) ; zwróci #t, ponieważ lista jest posortowana niemalejąco (elementy mogą być liczbami zmiennoprzecinkowymi)
