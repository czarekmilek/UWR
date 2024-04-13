#lang plait
; ...
; typ drzew
(define-type (Tree 'a)
  (leaf)
  (node [l : (Tree 'a)] [elem : 'a] [r : (Tree 'a)]))

; zalążek funkcji
(define (process-tree 
        [node-proc : ('a 'b 'c 'b -> 'b)] 
        [leaf-proc : ('a -> 'b)] 
        [lb-acc : ('a 'c -> 'a)]
        [rb-acc : ('a 'c -> 'a)] 
        [acc : 'a] 
        [tree : (Tree 'c)])
  (error "NotImplemented"))

; plik z poprzedniej listy

; mój fold
(define (tree-fold proc init tree)
  (cond [(leaf? tree) init]
        [(node? tree)
         (proc
          (tree-fold proc init (node-l tree))
          (node-elem tree)
          (tree-fold proc init (node-r tree)))]))