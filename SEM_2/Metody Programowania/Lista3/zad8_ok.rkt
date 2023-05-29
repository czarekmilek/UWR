#lang racket

(define (list->llist xs)
  (lambda (ys) (append xs ys)))

;argument podany na wejściu to pierwotnej funkcji '(1 2), potem '(3 4)
((list->llist '(1 2)) '(3 4)) ;test


(define w (list->llist '(1 2)))
(w '(3 4))


(define (llist->list f) (f empty))

;podaję funkcję, zwracam listę
(llist->list w) ;test


(define (llist-null)
  (lambda (x) (append `() x)))

(llist->list (llist-null))


(define (llist-singleton x)
  (lambda (y) (append (list x) y))
  )

(define f (llist-singleton 42))
(f '(1 2 3)) ; zwraca listę (42 1 2 3)

(llist->list (llist-singleton 3)) ;test



; wywołuję g(x), a później f(g(x))
(define (llist-append f g)
  (lambda (x) (f (g x)))
  )


(define h (list->llist '(1 2)))
(define i (list->llist '(3 4)))

(define j (llist-append (list->llist '(1 2 3)) (list->llist '(4 5 6))))

;(append (f (g null) null) x)
(j '())

;przy pierwszym wywołaniu będzie y=4 x=null
(define (foldr-llist-reverse list)
  (llist->list
   (foldr
    (lambda (x y) (llist-append y (llist-singleton x))) (llist-null) list)
  )
 )


;(f 1 (f 2 (f 3 (f 4 (llist-append(5 {}))))))
;(f 1 (f 2 (f 3 (llist-append(4 {5}))))
;(f 1 (f 2 (llist-append(3 {5 4}))))
;...
;(llist-append 1 {5 4 3 2}
;llist->list(llist->append {5 4 3 2 1} {})
;{5 4 3 2 1}

(foldr-llist-reverse '(1 2 3 4 5))