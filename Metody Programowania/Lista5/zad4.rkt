#lang plait


(define (remove x lst)
  (cond
    ((empty? lst) '())  ; jeśli lista jest pusta, zwracamy pustą listę
    ((eq? x (first lst)) (remove x (rest lst))) ; jeśli pierwszy element listy to x, to pomijamy go i rekurencyjnie usuwamy z reszty listy
    (else (cons (first lst) (remove x (rest lst)))))) ; w przeciwnym przypadku zachowujemy pierwszy element i rekurencyjnie usuwamy z reszty listy

(define (append-map f lst) ;Dodajemy do wyniku wszystkie elementy wygenerowane przez f(x)
  (foldr (lambda (x acc)
           (append (f x) acc))
         '()
         lst))

(define (perms lst)
  (if (empty? lst)
      '(())
      ; Dla każdego elementu w liście wywołujemy perms na liście bez tego elementu,
      ; a następnie przepinamy ten element na początek każdej permutacji i dodajemy ją
      ; do wyniku.
      (append-map (lambda (x)
                    (map (lambda (p) (cons x p))
                         (perms (remove x lst))))
                  lst)))

;dla każdego elementu x listy lst wywołuje perms na liście bez x ((perms (remove x lst))).
;Dla każdej permutacji listy bez x p, konstruuje nową permutację poprzez dodanie x na początek ((cons x p)).
;Otrzymane w ten sposób permutacje są następnie dopisywane do akumulatora wynikowego z użyciem append.
;Na końcu, po wykonaniu operacji append-map dla każdego elementu x listy lst,
;funkcja zwraca listę zawierającą wszystkie uzyskane permutacje.
