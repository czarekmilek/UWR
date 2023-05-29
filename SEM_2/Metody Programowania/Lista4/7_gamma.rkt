#lang racket

(define empty-c  (cons '() '()))
(define (queue-empty? q) (and (empty? (car q)) (empty? (cdr q))))
(define (push-back x q) (cons (car q) (cons x (cdr q))))
(define (front q) (if (queue-empty? q) null (car (car q))))

(define (pop q) (cond [(queue-empty? q) q]
                      [(= 1 (length (car q))) (cons (reverse (cdr q)) '())]
                      [else (cons (cdr (car q)) (cdr q))]))

(define (list->queue lst) (if (empty? lst) (cons '() '()) (cons (list (car lst)) (reverse (cdr lst)))))
(define (queue->list q) (append (car q) (reverse (cdr q))))

;; test dla empty-c
(define q1 empty-c)
(queue-empty? q1) ;; expected: #t

;; test dla push-back
(define q2 (list->queue '(1 2 3)))
(queue->list q2) ;; expected: '(1 2 3 4)
(queue->list (push-back 4 q2))
(queue->list (push-back 5 (push-back 4 q2)))

;; test dla front
(define q3 (list->queue '(1 2 3)))
(front q3) ;; expected: 1

;; test dla pop
(define q4 (list->queue '(1 2 3)))
(queue->list q2) ;; (1 2 3)
(queue->list (pop q2)) ;; (2 3)
(queue->list (pop (pop q2))) ;; (3)
             
;; test dla list->queue
(list->queue '()) ;; expected: '(())
(list->queue '(1)) ;; expected: '((1))
(list->queue '(1 2 3)) ;; expected: '((1) (3 2))

;; test dla queue->list
(define q5 (list->queue '(1 2 3)))
(queue->list q5) ;; expected: '(1 2 3)