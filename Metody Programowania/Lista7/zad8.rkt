#lang racket

;określenie po czyjej stronie leży błąd
(define (raise-contract-violation pol val)
  (error "Contract violation\nBlaming:"
                (if pol 'Programmer 'User)))

(struct contract [wrap])

;Funkcja wrap-contract tworzy nowy kontrakt, który opakowuje wartość w kontrakt na pozycji pozytywnej.
(define (wrap-contract c v)
  (wrap-with-polarity #t c v))

;;;;;;;;;;;;;;;;;;;;;;;;

#;(define (wrap-with-polarity pol c v)
  (if (contract? c)
      ((contract-wrap c) pol v)
      (if (c v)
          v
          (raise-contract-violation pol v))))

;Funkcja wrap-with-polarity działa poprawnie dla kontraktów na pozycji pozytywnej,
;ponieważ dla nich wymagane jest opakowanie wartości w kontrakt.
;Jednakże dla kontraktów na pozycji negatywnej, funkcja wrap-with-polarity nie działa poprawnie,
;ponieważ kontrakt na negatywnej pozycji oznacza, że nieprawidłowe wartości powinny być
;zgłaszane jako błędy, a nie opakowywane w kontrakty.
;Dlatego należy w takim przypadku zwrócić wartość bez jej pakowania w kontrakt.

(define (wrap-with-polarity pol c v)
  (if (contract? c)
      (if pol
          ((contract-wrap c) pol v)
          v)
      (if (c v)
          v
          (raise-contract-violation pol v))))

; Wprowadzamy zmianę, która sprawdza, czy kontrakt jest na pozycji negatywnej i jeśli tak,
; to wartość nie jest pakowana w kontrakt, tylko jest zwracana bezpośrednio.
; W przeciwnym przypadku zachowanie funkcji wrap-with-polarity pozostaje niezmienione
;;;;;;;;;;;;;;;;;;;;;;;

;Funkcja ->/c jest wykorzystywana do definiowania kontraktów dla funkcji. 
;Funkcja przyjmuje listę argumentów oraz wartość, którą funkcja powinna zwrócić, 
;a następnie zwraca nową funkcję, która zawiera kontrakty dla każdego argumentu oraz wartości zwracanej
(define (->/c . cs)
  (define arity (- (length cs) 1)) ;liczba argumentów listy
  (define val/c (last cs)) ;ostatni element listy
  (define arg/cs (take cs arity)) ;pozostale argumenty
  ;Funkcja wrap jest funkcją, która
  ;przyjmuje funkcję f jako argument i zwraca funkcję, która opakowuje f z wykorzystaniem kontraktów.
  (define (wrap pol f)
    (lambda xs
      (define args
        (map (curry wrap-with-polarity (not pol))
             arg/cs
             xs))
      (wrap-with-polarity pol val/c (apply f args))))
  (contract wrap))

(struct box [tag val])

;Funkcja box/c tworzy kontrakt, który sprawdza, czy wartość przekazana 
;jako argument jest obiektem typu box o oczekiwanym tagu.
(define (box/c tag)
  (define (wrap pol val)
    (if pol
        ;Jeśli pol jest ustawione na wartość true, funkcja wrap sprawdza,
        ;czy wartość val jest obiektem typu box oraz czy jego tag jest równy tag przekazanemu do funkcji box/c
        (if (and (box? val) (eq? tag (box-tag val)))
            (box-val val) ; funkcja wrap zwraca wartość przechowywaną w polu val obiektu box
            (raise-contract-violation pol val)) ;W przeciwnym przypadku wywołuje się funkcja raise-contract-violation
        (box tag val)))
  (contract wrap))

;Funkcja parametric/c służy do definiowania kontraktów dla funkcji o zmiennej liczbie argumentów
(define (parametric/c body)
  (define arity (procedure-arity body)) ;liczba argumentów
  ;lista cs, która składa się z kontraktów typu box/c o unikalnych tagach
  ;wygenerowanych za pomocą funkcji gensym. Liczba elementów w tej liście odpowiada liczbie argumentów funkcji.
  (define cs (map (lambda (i) (box/c (gensym))) (range arity)))
  ;funkcja body jest wywoływana z listą argumentów cs, używając funkcji apply.
  ;Funkcja parametric/c zwraca kontrakt dla funkcji body stworzony za pomocą funkcji contract
  (apply body cs))

;;;;;;;;;;

(define bar
  (wrap-contract
   (->/c (parametric/c (lambda [a] (->/c a a))) number?)
   (lambda (f) (f 42))))

(bar identity)
