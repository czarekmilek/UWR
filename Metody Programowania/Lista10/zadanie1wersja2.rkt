#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op] [args : (Listof Exp)])) ;zmiana

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{SYMBOL ANY ...} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (map parse (rest (s-exp->list s))))]
    [else (error 'parse "invalid input")]))

(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [else (error 'parse "unknown operator")]))
                 
(module+ test
  (test (parse `(+))
        (opE (add) '()))
  (test (parse `2)
        (numE 2))
  (test (parse `{+ 2 1 9 9})
        (opE (add) (list (numE 2) (numE 1) (numE 9) (numE 9))))
  (test (parse `{* 3 4 4})
        (opE (mul) (list (numE 3) (numE 4) (numE 4))))
  (test (parse `{+ {* 3 4} 8 8})
        (opE (add)
             (list (opE (mul) (list (numE 3) (numE 4)))
             (numE 8) (numE 8)))))
  
;; eval --------------------------------------

(define-type-alias Value Number)

(define (apply [f : (Value Value -> Value)] [acc : Value] [xs : (Listof Value)]) : Value
  (cond [(empty? xs) acc]
        [(empty? (rest xs)) (f acc (first xs))]
        [else (apply f (f acc (first xs)) (rest xs))]))

(define (op->proc [op : Op]) : ((Listof Value) -> Value)
  (type-case Op op
    [(add) (lambda (args) (apply + 0 args))]
    [(sub) (lambda (args) (cond [(= (length args) 0) 0]
                                [(= (length args) 1) (first args)]
                                [else (- (first args) (apply + 0 (rest args)))]))]
    [(mul) (lambda (args) (apply * 1 args))]
    [(div) (lambda (args) (cond [(= (length args) 0) 0]
                                [(= (length args) 1) (first args)]
                                [else (/ (first args) (apply * 1 (rest args)))]))]))

#;(define (op->proc [op : Op]) : ((Listof Value) -> Value)
  (type-case Op op
    [(add) (lambda (args) (apply + 0 args))]
    [(sub) (lambda (args) (apply - (first args) (rest args)))]
    [(mul) (lambda (args) (apply * 1 args))]
    [(div) (lambda (args) (apply / (first args) (rest args)))]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) n]
    [(opE o args) ((op->proc o) (map eval args))]))

(define (run [e : S-Exp]) : Value
  (eval (parse e)))

(module+ test
  (test (run `{+})
        0)
  (test (run `2)
        2)
  (test (run `{+ 2 1})
        3)
  (test (run `{* 2 2 1})
        4)
  (test (run `{- {* 2 3} {+ 5 3 2 8}})
        -12)
  (test (run `{+ 2})
        2)
  (test (run `{/ 10 5 2})
        1)
  (test (run `{/ 10 10})
        1)
  (test (run `{- 10})
        10)
  )

;; printer ———————————————————————————————————-

(define (print-value [v : Value]) : Void
  (display v))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))