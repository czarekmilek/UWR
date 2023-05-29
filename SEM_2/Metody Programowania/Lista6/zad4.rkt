#lang plait

;Zadanie 4

( define-type ( NNF 'v )
( nnf-lit [ polarity : Boolean ] [ var : 'v ])
( nnf-conj [ l : ( NNF 'v ) ] [ r : ( NNF 'v ) ])
( nnf-disj [ l : ( NNF 'v ) ] [ r : ( NNF 'v ) ]) )

(define (neg-nnf x)
  (cond [(nnf-lit? x)
         
         (if (nnf-lit-polarity x)
             (nnf-lit #f (nnf-lit-var x))
             (nnf-lit #t (nnf-lit-var x)))]

        [(nnf-conj? x) (nnf-disj (neg-nnf (nnf-conj-l x))
                                 (neg-nnf (nnf-conj-r x)))]

        [(nnf-disj? x) (nnf-conj (neg-nnf (nnf-disj-l x))
                                 (neg-nnf (nnf-disj-r x)))]))


;Zadanie 5

(define (eval-nnf σ fi)
  (cond
    
    [(nnf-lit? fi)
     (if (nnf-lit-polarity fi)
         (σ (nnf-lit-var fi))
         (not (σ (nnf-lit-var fi))))]

    [(nnf-conj? fi)
     (and (eval-nnf σ (nnf-conj-l fi))
          (eval-nnf σ (nnf-conj-r fi)))]

    [(nnf-disj? fi)
     (or (eval-nnf σ (nnf-disj-l fi))
         (eval-nnf σ (nnf-disj-r fi)))]

    ))

(display "Test Zadania 5:
")

(define sigma
  (lambda (x)
    (cond [(eq? x 'a) #t]
          [(eq? x 'b) #f]
          [(eq? x 'c) #t]
          [(eq? x 'd) #f]
          )))

;nnf-lit #t 'a - oznacza po prostu 'a
;nnf-lit #f 'a - oznacza negację 'a
(define phi1 (nnf-lit #t 'a))
(define phi2 (nnf-lit #f 'b))
(define phi3 (nnf-conj (nnf-lit #t 'c) (nnf-lit #f 'd)))
(define phi4 (nnf-disj (nnf-lit #f 'c) (nnf-lit #t 'd)))
(define phi5 (nnf-disj (nnf-conj (nnf-lit #t 'a) (nnf-lit #f 'b)) (nnf-lit #t 'c)))
(define phi6 (nnf-conj (nnf-disj (nnf-lit #t 'a) (nnf-lit #f 'b)) (nnf-lit #f 'c)))

(equal? (eval-nnf sigma phi1) #t)
(equal? (eval-nnf sigma phi2) #t)
(equal? (eval-nnf sigma phi3) #t)
(equal? (eval-nnf sigma phi4) #f)
(equal? (eval-nnf sigma phi5) #t)
(equal? (eval-nnf sigma phi6) #f)


;"łatwiejsza wersja"
;(define (evaluate x)
;  (cond [(nnf-lit? x) (nnf-lit-polarity x)]
;        [(nnf-conj? x) (and (evaluate (nnf-conj-l x))
;                            (evaluate (nnf-conj-r x)))]
;        [(nnf-disj? x) (or (evaluate (nnf-disj-l x))
;                           (evaluate (nnf-disj-r x)))]))


;Zadanie 6

( define-type ( Formula 'v )
( var [ var : 'v ])
( neg [ f : ( Formula 'v ) ])
( conj [ l : ( Formula 'v ) ] [ r : ( Formula 'v ) ])
( disj [ l : ( Formula 'v ) ] [ r : ( Formula 'v ) ]) )


(define (to-nnf objekt)
  (cond
    [(var? objekt) (nnf-lit #t (var-var objekt))]
    [(conj? objekt) (nnf-conj (to-nnf (conj-l objekt)) (to-nnf (conj-r objekt)))]
    [(disj? objekt) (nnf-disj (to-nnf (disj-l objekt)) (to-nnf (disj-r objekt)))]
    [(neg? objekt) (neg-nnf (to-nnf (neg-f objekt)))]))

(display "Test Zadania 6:
")

(define objekt1 (var 'p))
(equal? (to-nnf objekt1) (nnf-lit #t 'p))
(define objekt2 (neg (var 'q)))
(equal? (to-nnf objekt2) (nnf-lit #f 'q))
(define objekt3 (conj (var 'p) (var 'q)))
(equal? (to-nnf objekt3) (nnf-conj (nnf-lit #t 'p) (nnf-lit #t 'q)))
(define objekt4 (disj (neg (var 'p)) (neg (var 'q))))
(equal? (to-nnf objekt4) (nnf-disj (nnf-lit #f 'p) (nnf-lit #f 'q)))
(define objekt5 (disj (conj (var 'p) (var 'q)) (neg (disj (var 'r) (var 's)))))
(equal? (to-nnf objekt5) (nnf-disj (nnf-conj (nnf-lit #t 'p) (nnf-lit #t 'q)) (neg-nnf (nnf-disj (nnf-lit #t 'r) (nnf-lit #t 's)))))



;Zadanie 7

(define (eval-formula σ objekt)
    [eval-nnf sigma (to-nnf objekt)])


(define (eval-new σ fi)
  (cond
    [(var? fi)
     (σ fi)]
    [(neg? fi)
     (not (eval-new σ (neg-f fi)))]
    [(conj? fi)
     (and (eval-new σ (conj-l fi))
          (eval-new σ (conj-r fi)))]
    [(disj? fi)
     (or (eval-new σ (disj-l fi))
         (eval-new σ (disj-r fi)))]))


(display "Test Zadania 7:
")

(define beta1 (var 'a))
(define beta2 (var 'b))
(define beta3 (conj (var 'c) (var 'd)))
(define beta4 (disj (var 'c) (var 'd)))
(define beta5 (disj (conj (var 'a) (var 'b)) (var 'c)))
(define beta6 (conj (disj (var 'a) (var 'b)) (var 'c)))

(equal? (eval-formula sigma beta1) #t)
(equal? (eval-formula sigma beta2) #f)
(equal? (eval-formula sigma beta3) #f)
(equal? (eval-formula sigma beta4) #t)
(equal? (eval-formula sigma beta5) #t)
(equal? (eval-formula sigma beta6) #t)


