#lang racket

(define morse-alphabet
  '((#\a . ".-") (#\b . "-...") (#\c . "-.-.") (#\d . "-..")
                 (#\e . ".") (#\f . "..-.") (#\g . "--.") (#\h . "....")
                 (#\i . "..") (#\j . ".---") (#\k . "-.-") (#\l . ".-..")
                 (#\m . "--") (#\n . "-.") (#\o . "---") (#\p . ".--.")
                 (#\q . "--.-") (#\r . ".-.") (#\s . "...") (#\t . "-")
                 (#\u . "..-") (#\v . "...-") (#\w . ".--") (#\x . "-..-")
                 (#\y . "-.--") (#\z . "--..") (#\0 . "-----") (#\1 . ".----")
                 (#\2 . "..---") (#\3 . "...--") (#\4 . "....-") (#\5 . ".....")
                 (#\6 . "-....") (#\7 . "--...") (#\8 . "---..") (#\9 . "----.")
                 (#\. . "*") (#\_ . "_")))

(define (lookup-morse-char ch)
  (cdr (assq ch morse-alphabet)))

(define (morse-encode-char ch)
  (cond
    ((char-whitespace? ch) ""); obsluga bialych znakow
    ((lookup-morse-char (char-downcase ch)))
    (else (error "Nieznany znak"))))

(define (reduce-multiple-spaces str)
  (let ((result "")
        (prev-char #\space))
    (for-each (lambda (char)
                (cond
                  ((and (char=? char #\space) (char=? prev-char #\space)))
                  (else (set! result (string-append result (string char)))))
                (set! prev-char char))
              (string->list str))
    result))

(define (morse-encode str)
  (string-join
   (map morse-encode-char
        (string->list (reduce-multiple-spaces str)))
   " ")) ; spacja między znakami

(morse-encode "Metody Programowania")