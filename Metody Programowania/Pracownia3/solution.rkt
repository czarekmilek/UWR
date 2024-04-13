#lang plait

;;;;;;;;;;;;;;;;;;;;;;;;;
;Typy
(define-type-alias Value Number)

(define-type Exp
  (numE [num : Number])
  (varE [var : Symbol])
  (opE  [op : Op] [l : Exp] [r : Exp])
  (ifzE [if : Exp] [true : Exp] [false : Exp])
  (appE [sym : Symbol] [args : (Listof Exp)])
  (defE [args : (Listof Exp)] [eexp : Exp])
  (letE [var : Symbol] [exp1 : Exp] [exp2 : Exp])
  (funE [var : Symbol] [args : (Listof Exp)] [exps : Exp]))

(define-type Op
  (add) (sub) (mul) (less_or_equal))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;Pomocnicze (do parsowania)

(define (fifth [args : (Listof 'a)]) : 'a
  (list-ref args 4))

(define (sixth [args : (Listof 'a)]) : 'a
  (list-ref args 5))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;Parser

(define (parse [s_exp : S-Exp]) : Exp
  (if (s-exp-match? `{define {ANY ...} for ANY} s_exp)
      (defE (map parse (s-exp->list (second (s-exp->list s_exp))))
        (parse-exp (fourth (s-exp->list s_exp))))
      (parse-exp s_exp)))

(define (parse-exp [s_exp : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s_exp)
     (numE (s-exp->number s_exp))]
    [(s-exp-match? `SYMBOL s_exp)
     (varE (s-exp->symbol s_exp))]
    [(s-exp-match? `{ANY SYMBOL ANY} s_exp)
     (opE (parse-op (s-exp->symbol (second (s-exp->list s_exp))))
          (parse-exp (first (s-exp->list s_exp)))
          (parse-exp (third (s-exp->list s_exp))))]
    [(s-exp-match? `{ifz ANY then ANY else ANY} s_exp)
     (ifzE (parse-exp (second (s-exp->list s_exp)))
           (parse-exp (fourth (s-exp->list s_exp)))
           (parse-exp (sixth (s-exp->list s_exp))))]
    [(s-exp-match? `{SYMBOL {ANY ...}} s_exp)
     (appE (s-exp->symbol (first (s-exp->list s_exp)))
           (map parse (s-exp->list (second (s-exp->list s_exp)))))]
    [(s-exp-match? `{let SYMBOL be ANY in ANY} s_exp)
     (letE (s-exp->symbol (second (s-exp->list s_exp)))
           (parse-exp (fourth (s-exp->list s_exp)))
           (parse-exp (sixth (s-exp->list s_exp))))]
    [(s-exp-match? `{fun SYMBOL {ANY ...} = ANY} s_exp)
     (funE (s-exp->symbol (second (s-exp->list s_exp)))
           (map parse (s-exp->list (third (s-exp->list s_exp))))
           (parse-exp (fifth (s-exp->list s_exp))))]
    [else (error 'parse "Error: wrong input")]
    ))

(define (<= [x : Value] [y : Value]) : Value
  (if (or (< x y) (= x y))
      0
      1))

(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '<=) (less_or_equal)]
    [else (error 'parse "Error: unkown operator")]
    ))

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) +]
    [(sub) -]
    [(mul) *]
    [(less_or_equal) <=]
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;Środowisko

(define-type Binding
  (bind [symbol : Symbol]
        [content : 'a]))

(define-type-alias Environment (Listof Binding))

(define mt-env empty)

(define (extend-env [env : Environment] [symbol : Symbol] [content : 'a]) : Environment
  (cons (bind symbol content) env))

(define (extend-var-env [env : Environment] [args_list : (Listof Exp)] [vars_list : (Listof Value)]) : Environment
  (type-case (Listof Exp) args_list
    [empty env]
    [(cons var rst-vars)
     (type-case Exp var
       [(varE x)
        (if (part_of_env? env x)
            (error 'eval "Error: argument is not available (taken)")
            (extend-var-env (extend-env env x (first vars_list)) rst-vars (rest vars_list)))]
       [else (error 'eval "Error: argument is not valid")])]
    ))

(define (extend-fun-env [env : Environment] [args : (Listof Exp)]) : Environment
  (type-case (Listof Exp) args
    [empty env]
    [(cons fun rst-funs)
     (type-case Exp fun
       [(funE name args b)
        (if (part_of_env? env name)
            (error 'eval "Error: identifiers not unique")
            (extend-fun-env (extend-env env name fun) rst-funs))]
       [else (error 'eval "Error: a non-function")])]
    ))

(define (search [env : Environment] [sym : Symbol]) : 'a
  (type-case (Listof Binding) env
    [empty (error 'lookup "Error: unbound variable")]
    [(cons b rst-env)
     (cond
       [(eq? sym (bind-symbol b))
        (bind-content b)]
       [else
        (search rst-env sym)])]
    ))

(define (part_of_env? [env : Environment] [sym : Symbol]) : Boolean
  (type-case (Listof Binding) env
    [empty #f]
    [(cons b rst-env)
     (cond
       [(eq? sym (bind-symbol b))
        #t]
       [else
        (part_of_env? rst-env sym)])]
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;Ewaluacja

(define (eval [exp : Exp] [env1 : Environment] [env2 : Environment]) : Value
  (type-case Exp exp
    [(defE funs e)
     (eval e env1 (extend-fun-env env2 funs))]
    [(numE n) n]
    [(opE o l r)
     ((op->proc o) (eval l env1 env2) (eval r env1 env2))]
    [(ifzE e0 e1 e2)
     (if (= (eval e0 env1 env2) 0)
         (eval e1 env1 env2)
         (eval e2 env1 env2))]
    [(varE x)
     (search env1 x)]
    [(letE x e1 e2)
     (let ([v1 (eval e1 env1 env2)])
       (eval e2 (extend-env env1 x v1) env2))]
    [(funE name args b)
     (error 'eval "Error : function not applied to arguments")]
    [(appE f args)
     (apply f args env1 env2)]
    ))

(define (apply [sym : Symbol] [args : (Listof Exp)] [env1 : Environment] [env2 : Environment]) : Value
  (type-case Exp (search env2 sym)
    [(funE name vars b)
     (let ([new-var-env (extend-var-env mt-env vars (eval-args args env1 env2))])
       (eval b new-var-env env2))]
    [else (error 'apply "Error: type error")]
    ))

(define (eval-args [args : (Listof Exp)] [env1 : Environment] [env2 : Environment]) : (Listof Value)
  (type-case (Listof Exp) args
    [empty empty]
    [(cons arg rst-args)
     (cons (eval arg env1 env2) (eval-args rst-args env1 env2))]
    ))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;Run

(define (run [program : S-Exp]) : Value
  (eval (parse program) mt-env mt-env))