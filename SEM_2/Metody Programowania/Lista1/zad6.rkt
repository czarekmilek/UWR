#lang racket

(define ifCond #t)
(define ifTrue 1)
(define ifFalse 2)

(or (and ifCond ifTrue) (and (not ifCond) ifFalse))
(if ifCond ifTrue ifFalse)
(if #t 1 2)
(if #f 1 2)
(if (not ifCond) ifTrue ifFalse)