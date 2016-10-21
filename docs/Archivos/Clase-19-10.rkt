#lang racket

(require rackunit)

;; my-member :: A x List[A] -> bool
(define (suma-lista l)
  (display "l: ")
  (display l)
  (newline)
  (match l
    ['() 0]
    [(cons h t)
     (display h)
     (newline)
     (display t)
     (newline)
     (+ h (suma-lista t))]))
