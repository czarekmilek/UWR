#lang racket

(provide
 dequeue?
 (contract-out
   [dequeue-empty? (-> dequeue? boolean?)]
   [make-dequeue   (-> dequeue?)]
   [dequeue-push-front   (-> dequeue? any/c void?)]
   [dequeue-push-back   (-> dequeue? any/c void?)]
   [dequeue-pop-front    (-> dequeue? any/c)]
   [dequeue-pop-back    (-> dequeue? any/c)]
))


;kolejka
(struct dequeue (
                [front #:mutable]
                [back #:mutable]))

;elementy kolejki (listy dwukierunkowej)
(struct dnode
  (
   [value]
   [prev #:mutable]
   [next #:mutable]
   )
  )


;predykta, czy kolejka jest pusta
(define (dequeue-empty? q)
  (and (null? (dequeue-front q))
       (null? (dequeue-back  q))))

;utworzenie pustej kolejki
(define (make-dequeue)
  (dequeue null null))

; Dodawanie elementów na początek listy
(define (dequeue-push-front q x)
  ; Utworzenie elementu, który dodamy (jakiś dnode)
  (define new_elem (dnode x null null))
  (if (dequeue-empty? q)
      (begin
        ; Jesli kolejka jest pusta, wrzucam element z nullami na koniec
        (set-dequeue-front! q new_elem)
        (set-dequeue-back! q new_elem)
        )
      
      ; Jesli kolejka nie jest pusta, podmieniam wskaźniki
      (begin
        (set-dnode-next! new_elem (dequeue-front q)) ; Ustawiam jako next w dodawanym elemencie obecny front
        (set-dnode-prev! (dequeue-front q) new_elem) ; Ustawiam jako poprzedni element w obecnym front mój dodawany element new_elem
        ))
  (set-dequeue-front! q new_elem)) ; Zamieniam stary front na nowy element

;Dodawanie elementów na koniec listy
(define (dequeue-push-back q x)
  (define new_elem (dnode x null null))
  (if (dequeue-empty? q)
      (begin
        ;ustawienie na początkowym i końcowym miejscu nowego elementu, jak jeszcze nic nie było w liście
        (set-dequeue-front! q new_elem)
        (set-dequeue-back! q new_elem)
        )
      (begin
        (set-dnode-next! (dequeue-back q) new_elem) ;następcą back jest nowy element
        (set-dnode-prev! new_elem (dequeue-back q)) ;poprzednikiem nowego elementu jest obecny back
        )
      )
  (set-dequeue-back! q new_elem)
  )

(define (dequeue-pop-front q)
  (define popped (dequeue-front q));element do wyrzucenia
  (set-dequeue-front! q (dnode-next popped)) ;nowy front całej kolejki to next starego front
  (if (null? (dnode-next popped))
      (set-dequeue-back! q null) ;jak usuwany element był jedynym elementem, to back naszek kolejki także musi być nullem, (front jest już nullem, dzięki poprzedniemu)
      (set-dnode-prev! (dequeue-front q) null) ; wpp. poprzednik nowego fronta musi zostać nullem
      )
  (dnode-value popped);zwracam wartość usuniętego elementu
  )

(define (dequeue-pop-back q)
  (define popped (dequeue-back q))
  (set-dequeue-back! q (dnode-prev popped)) ;nowym back będzie poprzedni element względem starego ostatniego
  (if (null? (dnode-prev popped))
      (set-dequeue-front! q null) ;jak usuwany element był zarazem jedynym elementem, to ustawiamy także front na null
      (set-dnode-next! (dequeue-back q) null) ;wpp następnym elementem nowego back jest null
      )
  (dnode-value popped);zwracam wartość usuniętego elementu
  )







