#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div)
  (eql)
  (leq))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op]
       [l : Exp]
       [r : Exp])
  (ifE [b : Exp]
       [l : Exp]
       [r : Exp])
  (condE [cs : (Listof (Exp * Exp))])
  (consE [car : Exp] [cdr : Exp])
  (nullE [exp : Exp])
  (listE [elements : (Listof Exp)])
  (carE [exp : Exp])
  (cdrE [exp : Exp]))

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{if ANY ANY ANY} s)
     (ifE (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s)))
          (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{cond ANY ...} s)
     (condE (parse-cond (rest (s-exp->list s))))]
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s))))]
  [(s-exp-match? `{cons ANY ANY} s)
   (consE (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s))))]
  [(s-exp-match? `{car ANY} s)
   (carE (parse (second (s-exp->list s))))] 
  [(s-exp-match? `{cdr ANY} s)
   (cdrE (parse (second (s-exp->list s))))] 
  [(s-exp-match? `{null? ANY} s)
   (nullE (parse (second (s-exp->list s))))] 
  [(s-exp-match? `null s)
   (nullE '())]
  [(s-exp-match? `{list ANY ...} s)
   (listE (parse-list (rest (s-exp->list s))))]
  [else (error 'parse "invalid input")]))

(define (parse-list [ss : (Listof S-Exp)]) : (Listof Exp)
  (map parse ss))

(define (parse-cond [ss : (Listof S-Exp)]) : (Listof (Exp * Exp))
  (type-case (Listof S-Exp) ss
    [empty
     empty]
    [(cons s ss)
     (if (s-exp-match? `{ANY ANY} s)
         (cons (pair (parse (first (s-exp->list s)))
                     (parse (second (s-exp->list s))))
               (parse-cond ss))
         (error 'parse "invalid input: cond"))]))

(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [(eq? op '=) (eql)]
    [(eq? op '<=) (leq)]
    [else (error 'parse "unknown operator")]))
                
(module+ test
  (test (parse `2)
        (numE 2))
  (test (parse `{+ 2 1})
        (opE (add) (numE 2) (numE 1)))
  (test (parse `{* 3 4})
        (opE (mul) (numE 3) (numE 4)))
  (test (parse `{+ {* 3 4} 8})
        (opE (add)
             (opE (mul) (numE 3) (numE 4))
             (numE 8)))
  (test (parse `{if {= 0 1} {* 3 4} 8})
        (ifE (opE (eql) (numE 0) (numE 1))
             (opE (mul) (numE 3) (numE 4))
             (numE 8)))
   (test/exn (parse `{{+ 1 2}})
            "invalid input")
  (test/exn (parse `{+ 1})
            "invalid input")
  (test/exn (parse `{^ 1 2})
            "unknown operator")
  (test (parse `{cond {{= 0 1} {* 3 4}}
                      {{= 1 1} 8}})
        (condE (list (pair (opE (eql) (numE 0) (numE 1))
                           (opE (mul) (numE 3) (numE 4)))
                     (pair (opE (eql) (numE 1) (numE 1))
                           (numE 8)))))
  (test (parse `{cons 1 null})
        (consE (numE 1) (nullE '())))
  (test (parse `{car {cons 1 null}})
        (carE (consE (numE 1) (nullE '()))))
  (test (parse `{cdr {cons 1 null}})
        (cdrE (consE (numE 1) (nullE '()))))
  (test (parse `{null? null})
        (null?E (nullE '())))
  (test (parse `null)
        (nullE '()))
  (test (parse `{list 1 2 3})
        (listE (list (numE 1) (numE 2) (numE 3)))))
  
;; eval --------------------------------------

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean])
  (consV [carValue : Value]
         [cdrValue : Value])
  (nullV)
  (listV [elements : (Listof Value)]))

(define (op-num-num->proc [f : (Number Number -> Number)]) : (Value Value -> Value)
  (λ (v1 v2)
    (type-case Value v1
      [(numV n1)
       (type-case Value v2
         [(numV n2)
          (numV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (op-num-bool->proc [f : (Number Number -> Boolean)]) : (Value Value -> Value)
  (λ (v1 v2)
    (type-case Value v1
      [(numV n1)
       (type-case Value v2
         [(numV n2)
          (boolV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) (op-num-num->proc +)]
    [(sub) (op-num-num->proc -)]
    [(mul) (op-num-num->proc *)]
    [(div) (op-num-num->proc /)]
    [(eql) (op-num-bool->proc =)]
    [(leq) (op-num-bool->proc <=)]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(opE o l r) ((op->proc o) (eval l) (eval r))]
    [(ifE b l r)
     (type-case Value (eval b)
       [(boolV v)
        (if v (eval l) (eval r))]
       [else
        (error 'eval "type error")])]
    [(condE cs)
     (eval (cond->if cs))]
    [(consE carExp cdrExp)
     (let ([carValue (eval carExp)]
           [cdrValue (eval cdrExp)])
       (consV carValue cdrValue))]
    [(carE exp)
     (type-case Value (eval exp)
       [(consV carValue _)
        carValue]
       [else
        (error 'eval "type error")])]
    [(cdrE exp)
     (type-case Value (eval exp)
       [(consV _ cdrValue)
        cdrValue]
       [else
        (error 'eval "type error")])]
    [(nullE exp)
     (type-case Value (eval exp)
       [(nullV)
        (boolV #t)]
       [(consV a b)
        (boolV #f)]
       [else
        (error 'eval "type error")])]
    [(listE elements)
     (listV (eval-list elements))]))

(define (eval-list [expressions : (Listof Exp)]) : (Listof Value)
  (map eval expressions))

(define (cond->if [cs : (Listof (Exp * Exp))]) : Exp
  (type-case (Listof (Exp * Exp)) cs
    [empty
     (numE 42)]
    [(cons c cs)
     (ifE (fst c)
          (snd c )
          (cond->if cs))]))

(define (run [e : S-Exp]) : Value
  (eval (parse e)))

(module+ test
  (test (run `2)
        (numV 2))
  (test (run `{+ 2 1})
        (numV 3))
  (test (run `{* 2 1})
        (numV 2))
  (test (run `{+ {* 2 3} {+ 5 8}})
        (numV 19))
  (test (run `{= 0 1})
        (boolV #f))
  (test (run `{if {= 0 1} {* 3 4} 8})
        (numV 8))
  (test (run `{cond {{= 0 1} {* 3 4}}
                    {{= 1 1} 8}})
        (numV 8))
  (test (run `{cons 1 null})
        (consV (numV 1) (nullV)))
  (test (run `{car {cons 1 null}})
        (numV 1))
  (test (run `{cdr {cons 1 null}})
        (nullV))
  (test (run `{null? null})
        (boolV #t))
  (test (run `null)
        (nullV))
  (test (run `{list 1 2 3})
        (listV (list (numV 1) (numV 2) (numV 3)))))


;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]
    [(consV carValue cdrValue)
     (string-append "(" (value->string carValue) " . " (value->string cdrValue) ")")]
    [(nullV) "null"]
    [(listV elements)
     (string-append "(" (list->string elements) ")")]))

(define (list->string [elements : (Listof Value)]) : String
  (cond
    [(empty? elements) ""]
    [(empty? (rest elements))
     (value->string (first elements))]
    [else
     (string-append (value->string (first elements)) " " (list->string (rest elements)))]))


(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))