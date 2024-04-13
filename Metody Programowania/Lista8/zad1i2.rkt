#lang racket

(struct mlst (
                [front #:mutable]
                [back #:mutable]))

;sprawdzenie czy lista jest pusta
(define (mlst-empty? q)
  (and (null? (mlst-front q))
       (null? (mlst-back  q))))

;robi nową listę, z pustym front i back
(define (make-mlst)
  (mlst null null))

;wrzucamy element x na koniec listy q
(define (mlst-push q x)
  ;ostanim elementem ma być para (x null)
  (define p (mcons x null))
  (if (mlst-empty? q)
      ;jesli lista nic nie ma
      (set-mlst-front! q p)
      ;doklejamy p do ostaniej pary
      (set-mcdr! (mlst-back q) p))
  ;zmieniamy wskaźnik na back 
  (set-mlst-back! q p))


(define myList (make-mlst)) 

(mlst-push myList 10)
(mlst-push myList 20)
(mlst-push myList 30)

;(display (mlst-back myList))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;ZADANIE 1
(define (cycle! lst)
  (if (mlst-empty? lst)
      (error "No elements")
      ;przypinamy do back nowy front
      (set-mcdr! (mlst-back lst) (mlst-front lst))
      )
  )

(display "Zadanie 1:\n")
(display (mlst-front myList))
(display "\n")
(cycle! myList)
(display (mlst-front myList))

;ZADANIE 2
(define (mreverse! lst)
  (define (loop prev curr)
    (if (null? curr)
        (begin
          ;front i back nie są jeszcze na tym etapie zmienione wiec
          ;gdy dojdziemy do końca zamieniamy front i back
          ;czyli back staje się przodem
          (set-mlst-front! lst (mlst-back lst))
          ;a przód staje się tyłem
          ;(set-mcdr! prev null) ;dodajemy null (zwraca tylko pierwszy element odwróconej listy) 
          (set-mlst-back! lst prev)) ;zamiana tyłu
        (begin
          ;musimy zapamiętać wskaźnik na kolejny element
          (let ([next (mcdr curr)]
                )
               ;przestawiamy wskaźnik
              (set-mcdr! curr prev)
              ;robimy kolejny obieg pętli, poprzedim elementem, jest aktualny element
              (loop curr next )))
            )
         
         )
  (loop '() (mlst-front lst))
)


(define myList2 (make-mlst)) 

(mlst-push myList2 10)
(mlst-push myList2 20)
(mlst-push myList2 30)

(display "\n\nZadanie 2\nPrzed rewersem:\n")
(display (mlst-front myList2))
(mreverse! myList2)
(display "\nPo rewersie:\n")
(display (mlst-front myList2))
