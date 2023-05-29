#lang plait

(define-type Op
  (op-add) (op-mul) (op-sub) (op-div))

(define (parse-Op s)
  (let ([sym (s-exp->symbol s)])
  (cond
    [(equal? sym '+) (op-add)]
    [(equal? sym '-) (op-sub)]
    [(equal? sym '*) (op-mul)]
    [(equal? sym '/) (op-div)])))

(define (eval-op op)
  (type-case Op op
    [(op-add) +]
    [(op-sub) -]
    [(op-mul) *]
    [(op-div) /]))


; IMPLEMENTACJA
;połączenie parse-Exp z eval

(define (eval-exp s)
  (cond
    ;jesli s-wyrażenie jest liczbą, konwertuję s na liczbę
    [(s-exp-number? s) (s-exp->number s)]
    ;jesli jest listą to obliczam wartość
    [(s-exp-list? s)
     (let* ([xs (s-exp->list s)]
            ;parsuję do odpowiedniego symbolu
            [op (parse-Op (first xs))])
       
       (type-case Op op
         ;badam jaki mam dostępny symbol i rekurencyjnie obliczam wartości
         [(op-add) (+ (eval-exp (second xs)) (eval-exp (third xs)))]
         [(op-sub) (- (eval-exp (second xs)) (eval-exp (third xs)))]
         [(op-mul) (* (eval-exp (second xs)) (eval-exp (third xs)))]
         [(op-div) (/ (eval-exp (second xs)) (eval-exp (third xs)))]
         )
       )
     ]
    )
  )


; oczekiwany wynik: 5
(eval-exp `(+ 2 3))

; oczekiwany wynik: -1
(eval-exp `(- 2 3))

; oczekiwany wynik: 6
(eval-exp `(* 2 3))

; oczekiwany wynik: 0.5
(eval-exp `(/ 2 4))

; oczekiwany wynik: 9
(eval-exp `(+ 1 (* 2 4)))

(eval-exp `(- (+ 1 2) (* 2 4)))
