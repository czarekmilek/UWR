#lang plait

;('a 'b -> 'a)
(define (returns-x x a) x)

;(('a 'b - > 'c ) ('a - > 'b ) 'a - > 'c )

(define (fun x a) x)
(define (gun a) (gun a))
(define (hun fun gun a) (fun a (gun a)))

(define (fun2 x y z) (x z(y z)))

;((( 'a - > 'a ) - > 'a ) - > 'a )
(define (tun [f : (('a -> 'a) -> 'a)])
  (f (lambda (x) x)))

;(('a -> 'b) ('a -> 'c) -> ('a -> ('b * 'c)))
(define (run f g)
  (λ (a) (pair (f a) (g a))))

;(('a - > ( Optionof ('a * 'b ) ) ) 'a - > ( Listof 'b ) )
(define (kun [f : (' a -> (Optionof ('a * 'b)))]  a)
  (list (snd (some-v (f a))))
  )
