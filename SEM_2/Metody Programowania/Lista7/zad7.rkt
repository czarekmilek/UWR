#lang racket

(define (raise-contract-violation pol val)
  (error "Contract violation\nBlaming:"
                (if pol 'Programmer 'User)))

(struct contract [wrap])

(define (wrap-contract c v)
  (wrap-with-polarity #t c v))

(define (wrap-with-polarity pol c v)
  (if (contract? c)
      ((contract-wrap c) pol v)
      (if (c v)
          v
          (raise-contract-violation pol v))))

(define (->/c . cs)
  (define arity (- (length cs) 1))
  (define val/c (last cs))
  (define arg/cs (take cs arity))
  (define (wrap pol f)
    (lambda xs
      (define args
        (map (curry wrap-with-polarity (not pol))
             arg/cs
             xs))
      (wrap-with-polarity pol val/c (apply f args))))
  (contract wrap))


(struct box [tag val])

(define (box/c tag)
  (define (wrap pol val)
    (if pol
        (if (and (box? val) (eq? tag (box-tag val)))
            (box-val val)
            (raise-contract-violation pol val))
        (box tag val)))
  (contract wrap))

(define (parametric/c body)
  (define arity (procedure-arity body))
  (define cs (map (lambda (i) (box/c (gensym))) (range arity)))
  (apply body cs))



;;;;;;;;;;;;;;;;;


(define foo
   (wrap-contract
     (parametric/c (lambda [a]
                       (->/c boolean? a (->/c a any/c) any/c)))
     (lambda (b x f)
        (if b x (f (f x))))))
(foo #f (foo #t 42 identity) identity)