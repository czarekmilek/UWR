#lang racket

; operatory o najwyższym priorytecie muszą być najpóźniej w hierarchi
; zostaną obliczone po rozpisaniu całego wyrażenie jaki pierwsze, co sprawi że będą miały najwyższy priorytet 
; S - symbol startowy
; D - +/-
; M - *//
; E - ^
; U - -1
; F - !

S -> D
S -> D +/- M
D -> M
M -> M *// E
M -> E
E -> E ^ U
E -> U
U -> -F
U -> F
F -> F!
F -> N
N -> Number


np.
Wynik: 5*2+3^4! będzie miał postać:

(S
  (D
    (M
      (E
        (U
          (F
            (N
              (Number 5)
            )
          )
        )
      )
      *//
      (E
        (U
          (F
            (N
              (Number 2)
            )
          )
        )
      )
    )
  )
  +
  (M
    (E
      (U
        (F
          (N
            (Number 3)
          )
        )
      )
      ^ 
      (U
        (F
          (N
            (Number 4)
            !    
          )
        )
      )
    )
  )
)


;2 + 3 * 4! - 1 ^ 2
