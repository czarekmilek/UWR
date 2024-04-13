#lang plait

(define-type Prop
  (var [v : String])
  (conj [l : Prop] [r : Prop])
  (disj [l : Prop] [r : Prop])
  (neg [f : Prop]))

(define (not-in-list x xs)
  (cond [(empty? xs)           #t]
        [(equal? x (first xs)) #f]
        [else (not-in-list x (rest xs))]))

(define (rem-dupl xs) ;usuwanie duplikatow w liscie
  (local 
    [(define (remove xs ys)
            (cond [(empty? xs) ys]
                  ;jesli lista xs pusta zwroc pusta liste ys
                  [(not-in-list (first xs) ys) (remove (rest xs) (append ys (list (first xs))))]
                  ;wpp. sprawdza, czy pierwszy element listy występuje w pozostałej części listy xs
                  ;Jeśli nie występuje, to dodaje go do listy wynikowej ys
                  ;Następnie wykonuje tę samą funkcję dla reszty listy xs (bez pierwszego elementu),
                  ;przekazując do niej aktualną listę wynikową ys.
                  [else (remove (rest xs) ys)]))]
    
  (remove xs (list))))


; zwraca listę zmiennych wolnych występujących w wyrażeniu logicznym px
(define (free-vars px)
  (local 
    [(define (vars px xs)
      (cond [(var? px) (append xs (list (var-v px)))]
            ; gdy px jest zmienną, dodaje jej nazwę do listy xs
            [(neg? px) (vars (neg-f px) xs)]
            ; gdy px jest negacją, wywołuje funkcję free-vars dla wyrażenia będącego argumentem negacji
            [(conj? px) (append (vars (conj-l px) xs) (vars (conj-r px) xs))]
            [(disj? px) (append (vars (disj-l px) xs) (vars (disj-r px) xs))]))]
            ; w przypadku koniunkcji lub alternatywy,
            ; wywołuje funkcję free-vars dla obu argumentów i łączy wyniki
  (rem-dupl (vars px (list))))) ;na końcu usuwamy duplikaty


(define f1 (var "x"))
(define f2 (conj (var "x") (var "x")))
(define f3 (disj (neg (var "x")) (var "z")))
(define f4 (neg (conj (var "a") (disj (var "b") (var "c")))))

(free-vars f1) ; powinno zwrócić '(x)
(free-vars f2) ; powinno zwrócić '(x)
(free-vars f3) ; powinno zwrócić '(x z)
(free-vars f4) ; powinno zwrócić '(a b c)
;hash (( Listof ( ' a * 'b)) -> ( Hashof 'a 'b))
;hash-ref : (( Hashof 'a 'b) 'a -> ( Optionof 'b))
;hash-set : (( Hashof 'a 'b) 'a 'b -> ( Hashof 'a 'b))
(define x (conj
           (conj
            (disj (var "p") (neg (conj (var "q") (neg (var "q")))))
            (neg (var "p")))
           (disj (var "p")
                 (disj (var "s") (neg (var "s"))))))


(define (eval dict form)
  (cond [(var? form)  (some-v (hash-ref dict (var-v form)))]
        [(conj? form) (and (eval dict (conj-l form)) (eval dict (conj-r form)))]
        [(disj? form) (or (eval dict (disj-l form)) (eval dict (disj-r form)))]
        [(neg? form)  (not (eval dict (neg-f form)))]))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (tautology? px)
  (local [(define px-vars (free-vars px))
          (define (values vars d)
            (cond [(empty? vars) (eval d px)]
                  [else (and (values (rest vars) (hash-set d (first vars) #t))
                             (values (rest vars) (hash-set d (first vars) #f)))]))]
    (values px-vars (hash '()))))

(tautology? (disj (var "q") (neg (var "q"))))
(tautology? x)