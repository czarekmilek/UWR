#lang plait
;SKŁADNIA ABSTRAKCYJNA
;zdefiniujemy składnię abstrackyjną

(define-type UnaryOp
  (op-fact)
  (op-opo)
  )

(define-type BinaryOp
  (op-add)
  (op-mul)
  (op-sub)
  (op-div)
  (op-pow)
)

;to jest nasza składnia abstrakcyjna,
;czyli sposób reprezentacji naszej struktury
(define-type Exp
  (exp-number [n : Number])
  (exp-op1 [op : UnaryOp] [e : Exp])
  (exp-op2 [op : BinaryOp] [e1 : Exp] [e2 : Exp]))

;konwertowanie s-wyrażenia do symboli 
(define (parse-UnaryOp s)
  (let ([sym (s-exp->symbol s)])
    (cond
      [(equal? sym '!) (op-fact)]
      [(equal? sym '~) (op-opo)]
      )))

(define (parse-BinaryOp s)
  (let ([sym (s-exp->symbol s)])
    (cond
      [(equal? sym '+) (op-add)]
      [(equal? sym '-) (op-sub)]
      [(equal? sym '*) (op-mul)]
      [(equal? sym '/) (op-div)]
      [(equal? sym '^) (op-pow)]
      )))

;wykorzystamy cytowanie do parsowania
;` quasi cytownaie zwraca S-Exp `(+ 2 2) -> '(+ 2 2) - dostajemy z wyrażenie

;parse-Exp, korzystamy z s-wyrażeń
;s-exp->number s - bierze liczbę z s-wyrażenia

(define (parse-Exp s)
  (cond
    [(s-exp-number? s) (exp-number (s-exp->number s))]
    [(s-exp-list? s)
     (let ([xs (s-exp->list s)])
       ;rozważenie operatora binarnego i unarnego
       (if (= 2 (length xs))
           ;operator unarny
           (exp-op1 (parse-UnaryOp (first xs))
                    (parse-Exp (second xs))
                    )
           (exp-op2 (parse-BinaryOp  (first  xs))
               (parse-Exp (second xs))
               (parse-Exp (third  xs)))
           )
       )]))

; ==============================================
; INTERPRETER

(define (expt-helper x y acc)
  (if (= y 0)
      acc
      (expt-helper x (- y 1) (* acc x))))

(define (^ x y)
  (expt-helper x y 1))

(define (~ x)
  (* -1 x)
  )

(define (! x)
  (if (= 0 x)
      1
      (* x (! (- x 1)))))


;obliczanie dla działań unarnych
(define (eval-op1 op)
  (type-case UnaryOp op
    [(op-fact) !]
    [(op-opo) ~]))

;obliczanie dla działań binarnych
(define (eval-op2 op)
  (type-case BinaryOp op
    [(op-add) +]
    [(op-sub) -]
    [(op-mul) *]
    [(op-div) /]
    [(op-pow) ^]))


(define (eval e)
  (type-case Exp e
    [(exp-number n) n]
    ;operatory unarne
    [(exp-op1 op e) ((eval-op1 op) (eval e))]
    ;operatory binarne
    [(exp-op2 op e1 e2)
     ((eval-op2 op) (eval e1) (eval e2))]))

(define (eval-Exp s)
  (eval (parse-Exp s))
  )


(eval-Exp `(+ 2 2)) ; powinno wyświetlić 4
(eval-Exp `(* 3 (+ 2 2))) ; powinno wyświetlić 12
(eval-Exp `(^ 2 3)) ; powinno wyświetlić 8
(eval-Exp `(~ 5)) ; powinno wyświetlić -5
(eval-Exp `(! 4)) ; powinno wyświetlić 24
