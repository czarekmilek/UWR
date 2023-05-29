#lang racket

(require "zad3m.rkt")

(define mydeq (make-dequeue))


(dequeue-empty? mydeq)

(dequeue-push-front mydeq 3)
(dequeue-push-back mydeq 4)
(dequeue-push-back mydeq 5)

(dequeue-empty? mydeq)

(dequeue-pop-front mydeq)
(dequeue-pop-back mydeq)
(dequeue-pop-back mydeq)

(dequeue-empty? mydeq)