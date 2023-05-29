#lang racket

(define (morse-code str)

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
      ((char-whitespace? ch) ""); dwie spacje dla dowolnych białych znaków
      ((lookup-morse-char (char-downcase ch)))
      (else (error "Nieznany znak"))))

  (string-join
   (map morse-encode-char
        (string->list str))
   " ")) ; spacja między znakami

(morse-code "Metody Programowania")