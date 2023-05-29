#lang racket

;; Kontrakt: (parametric->/c [a b] (-> a b a))
;; Opis: Procedura przyjmuje dwa argumenty typu 'a' i zwraca wartość typu 'b', a następnie wartość typu 'a'.
; negatywne - gdy b będzie tego samego typu co a/funkcja zwróci b zamiast a
; pozytywne - gdy b będzie innego typu niż a i zwrócimy a
(define/contract (example1 a b)
  [parametric->/c [a b] (-> a b a)]
  (begin
    (displayln "Procedura przyjmuje dwa argumenty typu 'a' i zwraca wartość typu 'b', a następnie wartość typu 'a'")
    b
    a))

;; Kontrakt: (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
;; Opis: Procedura przyjmuje funkcję o sygnaturze '(a b -> c)', funkcję o sygnaturze '(a b -> a)', zwracając wartość typu 'c' i wartość typu 'a'.
; negatywne - funkcja nie mająca odpowiedniej ilości argumentów/złym typie
; pozytywne - funkcje z odpowiednimi ilościami argumentów/typami
(define/contract (example2 f1 f2)
  (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
  (begin
    (displayln "Procedura przyjmuje funkcję o sygnaturze '(a b -> c)', funkcję o sygnaturze '(a b -> a)', zwracając wartość typu 'c' i wartość typu 'a'")
    (f1 (f2))
    (f2)))

;; Kontrakt: (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
;; Opis: Procedura przyjmuje funkcję o sygnaturze '(b -> c)', funkcję o sygnaturze '(a b -> b)', funkcję o sygnaturze '(a c -> c)', i zwraca wartość typu 'a'.
; negatywne - funkcje ze złymi typami/ilością argumentów
; pozytywne - funkcje z odpowiednią ilością/typami argumentów
(define/contract (example3 f1 f2 f3)
  (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
  (begin
    (displayln "Procedura przyjmuje funkcję o sygnaturze '(b -> c)', funkcję o sygnaturze '(a b -> b)', funkcję o sygnaturze '(a c -> c)', i zwraca wartość typu 'a'")
    (f2 (f3))
    (f1)
    (f3)))

;; Kontrakt: (parametric->/c [a] (-> (-> (-> a a) a) a))
;; Opis: Procedura przyjmuje funkcję o sygnaturze '((a -> a) -> a)', zwracając wartość typu 'a'.
; negatywne - funkcja o typie innym niż '((a -> a) -> a)'
; pozytywne - prawidłowa funkcja 
(define/contract (example4 f)
  (parametric->/c [a] (-> (-> (-> a a) a) a))
  (begin
    (displayln "Procedura przyjmuje funkcję o sygnaturze '((a -> a) -> a)', zwracając wartość typu 'a'")
    (f (lambda (x) x))))
