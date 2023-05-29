#lang racket


;bez kontraktu
(define (suffixes xs)
  (if (null? xs)
      (list '())
       ;dodaj do listy list każdą listę pochodzącą z wywołania rekurencyjnego
       (cons xs (suffixes (rest xs)) )
       )
  )
;bez kontraktu cpu time: 0 real time: 16 gc time: 0
;(suffixes (range 10))
;(time ( suffixes (range 3000)) (void))
(time ( suffixes (range 300000)) (void))


;z kontraktem
(define/contract (suffixes-ctr xs)
  (parametric->/c [a] (-> (listof a) (listof (listof a))) )
  (if (null? xs)
      (list '())
       ;dodaj do listy list każdą listę pochodzącą z wywołania rekurencyjnego
       (cons xs (suffixes (rest xs)) )
       )
  )

;cpu time: 562 real time: 577 gc time: 375
(time ( suffixes-ctr (range 3000)) (void))