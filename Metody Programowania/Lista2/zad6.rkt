#lang racket
(define (maximum xs)
  (if (null? xs)
      -inf.0
      (let loop ((xs xs)
                 (max -inf.0))
        (if (null? xs)
            max
            (let ((x (car xs)))
              (if (> x max)
                  (loop (cdr xs) x)
                  (loop (cdr xs) max)))))))


(maximum (list))    ; => -inf.0
(maximum (list 1 2 3 4))    ; => 4
(maximum (list 4 3 2 1))    ; => 4
(maximum (list 1 5 0 7 1 4 1 0))    ; => 7
(maximum (list 0.1 0.2 0.3 0.05))    ; => 0.3
(maximum (list -1 -5 -3))    ; => -1
