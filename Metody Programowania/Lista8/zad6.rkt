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
  [rtype-cond (conditions : (Listof (RacketExpression * RacketExpression) ))] ;cond  - lista warunków i wartości od nich zależnych
)