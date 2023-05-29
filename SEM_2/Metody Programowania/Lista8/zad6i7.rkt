#lang plait


;w tym zadaniu mamy wyrazić formy specjalne z Racketa za pomocą typów w plait
;wyrażenia składające się z:
;-zmiennych (typ Symbol)
;-liczb
;-lambda-wyrażenia
;-aplikacje (wywołania funkcji)
;-let
;-if
;-cond


(define-type RacketExpression
  [rtype-var (s : Symbol)] ;zmienna
  [rtype-number (n : Number) ] ;liczba
  [rtype-lambda (args : (Listof Symbol)) (body : RacketExpression)] ;lambda n argumentów i ciało funkcji
  [rtype-app (f : RacketExpression) (args : (Listof RacketExpression))] ;zwykła funkcja - f (n argumentów)
  [rtype-let (bindings : (Listof (Symbol * RacketExpression))) (body : RacketExpression)] ;let - n złączeń w let oraz ciało let'a
  [rtype-if (conditional : RacketExpression) (then-part : RacketExpression) (else-part : RacketExpression)] ;if - warunek oraz dwie gałęzie
  [rtype-condi (conditions : (Listof (RacketExpression * RacketExpression) ))] ;cond  - lista warunków i wartości od nich zależnych
)

;PARSER
;Na przykład, dla lambdy z jednym argumentem x ((lambda (x) (* x x))), (car (cdr s)) oblicza się do (x), a wynikiem przetwarzania map jest lista [(rtype-symbol 'x)]
;Na przykład dla lambdy z ciałem (* x x) ((lambda (x) (* x x))), (cadr (cdr s)) oblicza się do wyrażenia (* x x). Następnie, ciało to jest analizowane za pomocą funkcji parse-racket

;robimy strukturę typu lambda
;na początku konersja na listę s-symboli, następnie każdy s-symbol na zwykły symbol
(define (parse-list-lambda e)
  (let ([xs (s-exp->list e)]) ;przekształca wyrażenie e z s-expression na listę s-symboli
    ;każdy element listy jest przetwarzany przez funkcję, która przekształca s-symbol na zwykły symbol 
    (map (lambda (elem) (s-exp->symbol elem)) xs)
    ;wynikowy ciąg zwykłych symboli jest zwracany przez map jako lista symboli
    )
  )

;przyjujemy s wyrażenie będące listą, konwersja na listę s wyrażeń
(define (parse-list-let e)
  
  (let* (;otrzymujemy listę zdań w let
         [let-sen (s-exp->list e)]
         ;konwertuję je na listę złożoną z list s-wyrażeń
         [propper (map (lambda (sen) (s-exp->list sen)) let-sen)]
         )
    ;teraz w każdej liście złożonej z s-wyrażeń wyciągam odpowiednie elementy
    (map
     (lambda (sen-propper)
       (pair (s-exp->symbol (first sen-propper)) (parse-RacketExpression (second sen-propper) ))
       )
     propper)
    )
  )

(define (parse-list-cond conditions)
  (let* (;konwertuję warunki na listy s-wyrażeń
         [propper (map (lambda (cdt) (s-exp->list cdt)) conditions)]
         )
    ;teraz w każdej liście złożonej z s-wyrażeń wyciągam odpowiednie elementy
    (map
     (lambda (elem)
       (pair (parse-RacketExpression (first elem)) (parse-RacketExpression (second elem) ))
       )
     propper)
    )
  )


(define (parse-list-apply apps)
  (map (lambda (elem) (parse-RacketExpression elem)) apps)
  )


(define (parse-RacketExpression s)
  (cond
    [(s-exp-symbol? s) (rtype-var (s-exp->symbol s))] ; symbol
    [(s-exp-number? s) (rtype-number (s-exp->number s))] ; liczby
    [(s-exp-list? s)
     ;konwertujemy listę s na listę złożoną z symboli
     (let* ([xs (s-exp->list s)] [command (first xs)])
       (cond
         [(equal? command `lambda)
          (rtype-lambda
            (parse-list-lambda (second xs))
            (parse-RacketExpression (third xs)))]
         [(equal? command `let)
          (rtype-let
            (parse-list-let (second xs))
            (parse-RacketExpression (third xs)))]
         [(equal? command `if)
          (rtype-if
            (parse-RacketExpression (second xs))
            (parse-RacketExpression (third xs))
            (parse-RacketExpression (fourth xs)))]
         [(equal? command `cond)
          (rtype-condi
            (parse-list-cond (rest xs)))
          ]
         [else
          (rtype-app
           (parse-RacketExpression (first xs))
           (parse-list-apply (rest xs))
           )
          ]
         )
       )]))


(equal? (parse-RacketExpression `(+ 1 2))
        (rtype-app (rtype-var '+) (list (rtype-number 1) (rtype-number 2))))
(equal? (parse-RacketExpression `(lambda (x) (* x x)))
        (rtype-lambda (list 'x) (rtype-app (rtype-var '*) (list (rtype-var 'x) (rtype-var 'x)))))


