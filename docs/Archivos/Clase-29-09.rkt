#lang racket

(define MAX 100)

(define !λ=>-α/β?☺ 1)

(let (
      ;; Declaracion de identificadores
      ;; locales del let
      [x 3]
      [y 2]
      [z 1]
      )
  
  ;; CUERPO del let
  (+ x y z)
  
  )

;(+ x 1)

#|
(let ([x 1]
      [y (+  x x)])
  (+ y 1))
|#


(let ([x 1])
  (let ([y (+ x x)])
    (+ y 1)))

;(define x 894398)

(let ([x 1])
  (let ([x (+ x 1)])
    (let ([x 10])
      (+ x x x x x))))

(let* ([x 1]
       [y (+ x x)])
  (+ y 1))

(define (double x) ;; Forma de la función
  ;; Cuerpo de la función
  ;(+ x (let ([x 2]) (+ x 1))))
  (* 2 x))


(double 2)

(define (f x)
  (define y 10)
  (+ x y))

(f 1)

;; y

;(define (f y) (+ 1 y))

(define (g z)
  (define (f w) (+ 1 w))
  ;(define (f z) 1)
  (+ z (f z)))

(let ([x 1]
      ;;     [x 2])
      )
  (+ x x))

; comentario de una linea

#|
este es un
comentario
de
multiples
lineas
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (pick-random x y)
  (let ([monedita (random)])
    (if (> monedita 0.5)
        x
        y)))



;; n >= 0

(define (es-impar n)
  (cond [(equal? n 0) #f]
        [(equal? n 1)#t]
        [else (es-par (- n 1))]))

(define (es-par n)
  (cond [(equal? n 0) #t]
        [(equal? n 1) #f]
        [else (es-impar (- n 1))]))
#|
#include <stdio.h>

int es-impar(int n);
int es-par(int n);

int main () {
  ...
  return 0;
}

int es-impar(int n) { ... }

int es-par(int n) { ... }




|#


(es-par 10)

(printf "El valor de (es-par 10) es: ~a ~n" (es-par 10))

(es-par (double (double 1)))

(es-par (if (> 2 3) 1 2))



;; es-par( if (2 > 3) { return 1; } else { return 2;} )

#| if (2 > 3) {
      es-par(1);
   } else {
      es-par(2);
   }
|#

(es-par (if (> 2 3) 2 3))

(if (let ([x 1] [y 2]) (> y x)) 1 2)

;(if (> 2 3)
;    expr-verdadero
;    expr-falso)

;;;;;;;;;;;;;;;;;;;;
(define (cuadrado n)
  (* n n))  


(define (tres-cuadrados a b c)  
  (cond [(and (< a b) (< a c))
         (+ (cuadrado b) (cuadrado c))]
        [(and (< b a) (< b c))
         (+ (cuadrado a) (cuadrado c))]
        [else (+ (cuadrado a) (cuadrado b))]))





