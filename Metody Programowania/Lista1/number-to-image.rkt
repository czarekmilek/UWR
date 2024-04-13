;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5.00-countdown-to-image_solution) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(define PNAME 'countdown-to-image)
#|
CHEATSHEET: https://docs.racket-lang.org/htdp-langs/beginner.html
TEMPLATES: https://howtocode.pages.dev/htdp_templates
ASK FOR HELP: https://discord.com/invite/6Zq8sH5
Turn all ❌ into ✅ for each step you complete
== Data ==
    1. Data Description✅
    2. Interpretation✅
    3. Data Examples✅
    4. A function template that processes this data✅
== Functions ==
    1. Signature, purpose, stub ✅
    2. Examples (aka check-expect, elaborate the concrete) ✅
    3. Template(from data)?✅
    3. Code body ✅
    4. Test, review, and refactor(review all steps, ctrl+i to auto-format) ✅
|#

#|PROBLEM A:
Notice how the "CountDown" data definition below uses mixed types of data,
nameley a Boolean, Numbers, and String.

Finish writing the template for "CountDown"
|#

; A CountDown is one of:
; - #false
; - Natural[10, 0]
; - "complete"
; interp. 
; #false         means the countdown has not started
; Natural[10, 0] means its in the process of counting down
; "complete"     means it is done.
(define NOT-STARTED #false)
(define CD1 0)
(define COMPLETE "complete")

(define (countdown-temp cd)
  (cond
    [(and (boolean? cd) (boolean=? cd #f)) ...]
    [(and (number? cd) (>= cd 0) (<= cd 10)) (... cd)]
    [(and (string? cd) (string=? cd "complete")) ...]))

#|PROBLEM B:
Write the function "countdown->image" that consumes a CountDown
and produces an Image, for example:
#false should produce an empty-image
Numbers should produce the image of the number(use text)
"complete" should produce the image: "Happy New Years🎉!!!"
|#

; countdown : (CountDown -> Image)
; produces an Image of a CountDown as seen in NY Time Square
(check-expect (countdown-to-image #false) empty-image)
(check-expect (countdown-to-image 1) (text "1" 24 "blue"))
(check-expect (countdown-to-image "complete") (text "Happy New Years🎉!!!" 24 "red"))

(define (countdown-to-image cd)
  (cond
    [(and (boolean? cd) (boolean=? cd #false))
     empty-image]
    [(and (number? cd) (>= cd 0) (<= cd 10))
     (text (number->string cd) 24 "blue")]
    [(and (string? cd) (string=? cd "complete"))
     (text "Happy New Years🎉!!!" 24 "red")]))

(define (countdown-to-image-OPT cd)
  (cond
    [(boolean? cd) ; can be just boolean? cause data def states #false specifically
     empty-image]
    [(number? cd) ; because there are no other intervals, we dont need to test range
     (text (number->string cd) 24 "blue")]
    [else ; because there are no other strings, and this is the last case, we can just use else
     (text "Happy New Years🎉!!!" 24 "red")]))