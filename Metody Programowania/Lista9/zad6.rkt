#lang plait

(define-type Op
  (op-add) (op-mul) (op-sub) (op-div))

(define-type Exp
  (exp-number [n : Number])
  (exp-op [op : Op] [e1 : Exp] [e2 : Exp]))

(define-type (ParseResult 'a)
  (parse-err)
  (parse-ok [v : 'a] [rest : (Listof S-Exp)]))

(define (parse-op0 ss)
  (type-case (Listof S-Exp) ss
    [empty (parse-err)]
    [(cons op rest)
     (cond       [(s-exp-match? `+ op) (parse-ok (op-add) rest)]
       [(s-exp-match? `- op)
        (parse-ok (op-sub) rest)]
       [else (parse-err)])]))

(define (parse-op1 ss)
  (type-case (Listof S-Exp) ss
    [empty (parse-err)]
    [(cons op rest)
     (cond
       [(s-exp-match? `* op) (parse-ok (op-mul) rest)]
       [(s-exp-match? `/ op) (parse-ok (op-div) rest)]
       [else (parse-err)])]))

(define (parse-exp1 ss)
  (type-case (Listof S-Exp) ss
    [empty (parse-err)]
    [(cons s rest)
     (cond
       [(s-exp-number? s) (parse-ok (exp-number (s-exp->number s)) rest)]
       [(s-exp-list? s)
        (type-case (ParseResult Exp)
          (parse-exp1 (s-exp->list s))
          [(parse-err) (parse-err)]
          [(parse-ok e rest2)
           (if (empty? rest2)
               (parse-ok e rest)
               (parse-err))])])]))

(define (parse-exp0 ss)
  (type-case (ParseResult Exp) (parse-exp1 ss)
    [(parse-err) (parse-err)]
    [(parse-ok e1 rest)
     (type-case (ParseResult Op) (parse-op1 rest)
       [(parse-err)         (parse-ok e1 rest)]
       [(parse-ok op rest2)
        (type-case (ParseResult Exp)
          (parse-exp1 rest2)
          [(parse-err) (parse-err)]
          [(parse-ok e2 rest3) (parse-ok (exp-op op e1 e2) rest3)])])]))

(define (parse-exp s)
  (type-case (ParseResult Exp) (parse-exp0 (list s))
    [(parse-err) (error 'parse-exp "Syntax error")]
    [(parse-ok e rest)
     (if (empty? rest)
         e
         (error 'parse-exp "Syntax error"))]))

;;;;;;;;;;;

;; Testy dla operatora mnożenia

(parse-op0 `(2 * 3))

;(exp-op op-mul (exp-number 2) (exp-number 3))
;(equal? (parse-exp "2*3+4") (exp-op op-add (exp-op op-mul (exp-number 2) (exp-number 3)) (exp-number 4)))
;(equal? (parse-exp "2*3*4") (exp-op op-mul (exp-op op-mul (exp-number 2) (exp-number 3)) (exp-number 4)))

;; Testy dla operatora dzielenia
;(equal? (parse-exp "10/2") (exp-op op-div (exp-number 10) (exp-number 2)))
;(equal? (parse-exp "10/2+5") (exp-op op-add (exp-op op-div (exp-number 10) (exp-number 2)) (exp-number 5)))
;(equal? (parse-exp "10/2/5") (exp-op op-div (exp-op op-div (exp-number 10) (exp-number 2)) (exp-number 5)))

;; Testy dla łączenia operatorów
;(equal? (parse-exp "2+3*4") (exp-op op-add (exp-number 2) (exp-op op-mul (exp-number 3) (exp-number 4))))
;(equal? (parse-exp "2*3+4*5") (exp-op op-add (exp-op op-mul (exp-number 2) (exp-number 3)) (exp-op op-mul (exp-number 4) (exp-number 5))))
;(equal? (parse-exp "10/2/5*3") (exp-op op-mul (exp-op op-div (exp-op op-div (exp-number 10) (exp-number 2)) (exp-number 5)) (exp-number 3)))
