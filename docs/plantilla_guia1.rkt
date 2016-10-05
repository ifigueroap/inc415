#lang racket

(require rackunit)

;; Archivo -> Package Manager -> Install -> "quickcheck"
(require quickcheck)
(require rackunit/quickcheck)

;;
;; Defina sus funciones en este archivo. No modifique el contenido de los tests!
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (tres-cuadrados a b c)
  (define (sqr x) (* x x))  
  (cond
    [(and (<= c b) (<= c a)) (+ (sqr a) (sqr b))]
    [(and (<= b c) (<= b a)) (+ (sqr a) (sqr c))]
    [(and (<= a c) (<= a b)) (+ (sqr b) (sqr c))]))


(module+ test
  
  (check-equal? (tres-cuadrados 1 2 3) 13)
  (check-equal? (tres-cuadrados 0 0 0) 0)
  (check-equal? (tres-cuadrados 3 3 3) 18)
  (check-equal? (tres-cuadrados 1 2 3) (tres-cuadrados 3 2 1))
  (check-equal? (tres-cuadrados 3 2 1) (tres-cuadrados 1 3 2))
  (check-property (property ([a arbitrary-integer]
                             [b arbitrary-integer]
                             [c arbitrary-integer])
                            (= (tres-cuadrados a b c)
                               (tres-cuadrados a c b)
                               (tres-cuadrados b a c)
                               (tres-cuadrados b c a)
                               (tres-cuadrados c a b)
                               (tres-cuadrados c b a)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (factorial n) #f)  

(module+ test
  
  (check-equal? (factorial 0) 1)
  (check-equal? (factorial 1) 1)
  (check-equal? (factorial 2) 2)
  (check-equal? (factorial 5) 120)
  (check-equal? (factorial 10) (* 10 (factorial 9)))
  (check-property (property ([n (choose-integer 1 100)])                            
                            (= (factorial n) (* n (factorial (- n 1)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (fibs k) #f)  

(module+ test
  
  (check-equal? (fibs 1) 1)
  (check-equal? (fibs 2) 1)
  (check-equal? (fibs 3) 2)
  (check-equal? (fibs 4) 3)
  (check-equal? (fibs 5) 5)
  (check-equal? (fibs 6) 8)
  (check-equal? (fibs 7) 13)
  (check-property (property ([k (choose-integer 3 25)])
                            (= (fibs k) (+ (fibs (- k 1)) (fibs (- k 2)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; NO PUEDE USAR LA FUNCION expt PARA IMPLEMENTAR POTENCIA
;;; DEBE USAR RECURSIVIDAD
(define (potencia base exponente) #f)

(module+ test
  
  (check-property (property ([b arbitrary-integer]
                             [e arbitrary-natural])
                            (= (potencia b e) (expt b e)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (primo? n) #f)  

(module+ test
  
  (check-false (primo? 0))
  (check-false (primo? 1))
  (check-true (primo? 2))
  (check-true (primo? 3))
  (check-true (primo? 5))
  (check-true (primo? 7))
  (check-true (primo? 11))
  (check-true (primo? 1489))
  (check-true (primo? 2903))
  (check-true (primo? 7919))  
  (check-property (property ([n arbitrary-natural])
                            (if (and (even? n) (not (= n 2)))
                                (not (primo? n))
                                #t))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (a-suma-abs-b a b) #f)  

(module+ test
  (check-equal? (a-suma-abs-b 0 0) 0)
  (check-equal? (a-suma-abs-b 1 -1) 2)
  (check-equal? (a-suma-abs-b 1 1) 2)
  (check-property (property ([a arbitrary-integer]
                             [b arbitrary-integer])
                            (= (a-suma-abs-b a b) (a-suma-abs-b a (* -1 b))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-digitos n) #f)  

(module+ test
  (check-equal? (suma-digitos 0) 0)
  (check-equal? (suma-digitos 1) 1)
  (check-equal? (suma-digitos 2) 2)
  (check-equal? (suma-digitos 3) 3)
  (check-equal? (suma-digitos 4) 4)
  (check-equal? (suma-digitos 5) 5)
  (check-equal? (suma-digitos 6) 6)
  (check-equal? (suma-digitos 7) 7)
  (check-equal? (suma-digitos 8) 8)
  (check-equal? (suma-digitos 9) 9)
  (check-property (property ([a arbitrary-integer])
                            (= (suma-digitos a)
                               (+ (suma-digitos (quotient a 10)) (remainder a 10))))))    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (numero-central a b c) #f)  

(module+ test
  (check-equal? (numero-central 1 2 3) 2)
  (check-equal? (numero-central 3 1 2) 2)
  (check-equal? (numero-central 0 0 0) 0)
  (check-equal? (numero-central 1 (numero-central 2 3 4) (numero-central 5 6 7)) 3)
  (check-property (property ([a arbitrary-integer]
                             [b arbitrary-integer]
                             [c arbitrary-integer])
                            (= (numero-central a b c)
                               (numero-central a c b)
                               (numero-central b a c)
                               (numero-central b c a)
                               (numero-central c a b)
                               (numero-central c b a))))
  (check-property (property ([a arbitrary-integer]
                             [b arbitrary-integer]
                             [c arbitrary-integer])
                            (let ([central (numero-central a b c)])
                              (and (<= central (max a b c))
                                   (>= central (min a b c)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (alternante? n) #f)  

(module+ test
  (check-true (alternante? 0))
  (check-true (alternante? 1))
  (check-true (alternante? 2))  
  (check-true (alternante? 12))
  (check-true (alternante? 21))
  (check-true (alternante? 123))
  (check-true (alternante? 234))
  (check-false (alternante? 11))
  (check-false (alternante? 22))
  (check-false (alternante? 122))
  (check-false (alternante? 112))
  (check-false (alternante? 221))
  (check-false (alternante? 211)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (perfecto? n) #f)  

(module+ test
  (check-true (perfecto? 6))
  (check-true (perfecto? 28))
  (check-true (perfecto? 496))
  (check-true (perfecto? 8128))
  (check-true (perfecto? 33550336)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (agradable? n) #f)

(module+ test
  (check-false (agradable? 1))
  (check-true (agradable? 2))
  (check-false (agradable? 3))
  (check-false (agradable? 4))
  (check-false (agradable? 5))
  (check-true (agradable? 6))
  (check-false (agradable? 7))
  (check-false (agradable? 8))
  (check-false (agradable? 9))
  (check-property (property ([a arbitrary-natural])
                            (if (odd? a)
                                (not (agradable? a))
                                #t))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NO USAR LA FORMULA ALGEBRAICA n(n+1)(2n+1)/6

(define (suma-cuadrados k) #f)  

(module+ test
  (check-equal? (suma-cuadrados 0) 0)
  (check-equal? (suma-cuadrados 1) 1)
  (check-equal? (suma-cuadrados 2) 5)
  (check-property (property ([k arbitrary-natural])
                            (= (suma-cuadrados k)
                               (/ (* k (+ k 1) (+ (* 2 k ) 1)) 6)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Usar función predefinida 'cos'

(define (suma-cos k) #f)  

(module+ test
  (check-equal? (suma-cos 0) 0)
  (check-equal? (exact-round (suma-cos 1)) (exact-round 0.5403023058681398))
  (check-equal? (exact-round (suma-cos 2)) (exact-round 0.12415546932099736))
  (check-equal? (exact-round (suma-cos 3)) (exact-round -0.865837027279448))
  (check-equal? (exact-round (suma-cos 5)) (exact-round -1.2358184626798336))
  (check-equal? (exact-round (suma-cos 10)) (exact-round -1.4174477464559059))
  (check-equal? (exact-round (suma-cos 15)) (exact-round -0.28467200293615436))
  (check-equal? (exact-round (suma-cos 20)) (exact-round 0.5396085669330053))
  (check-equal? (exact-round (suma-cos 25)) (exact-round -0.12553272081882738)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-abstracta f k) #f)
  
(module+ test
  (check-equal? (suma-abstracta identity 0) 0)
  (check-equal? (suma-abstracta identity 1) 1)
  (check-equal? (suma-abstracta identity 2) 3)
  (check-property (property ([k arbitrary-natural])
                            (= (suma-abstracta identity k)
                               (/ (* k (+ k 1)) 2)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-cuadrados-abs k) #f)  

(module+ test
  (check-equal? (suma-cuadrados-abs 0) 0)
  (check-equal? (suma-cuadrados-abs 1) 1)
  (check-equal? (suma-cuadrados-abs 2) 5)
  (check-property (property ([k arbitrary-natural])
                            (= (suma-cuadrados-abs k)
                               (/ (* k (+ k 1) (+ (* 2 k ) 1)) 6)))))

;
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
(define (suma-cos-abs k) #f)  

(module+ test
  (check-equal? (suma-cos-abs 0) 0)  
  (check-equal? (exact-round (suma-cos-abs 1)) (exact-round 0.5403023058681398))
  (check-equal? (exact-round (suma-cos-abs 2)) (exact-round 0.12415546932099736))
  (check-equal? (exact-round (suma-cos-abs 3)) (exact-round -0.865837027279448))
  (check-equal? (exact-round (suma-cos-abs 5)) (exact-round -1.2358184626798336))
  (check-equal? (exact-round (suma-cos-abs 10)) (exact-round -1.4174477464559059))
  (check-equal? (exact-round (suma-cos-abs 15)) (exact-round -0.28467200293615436))
  (check-equal? (exact-round (suma-cos-abs 20)) (exact-round 0.5396085669330053))
  (check-equal? (exact-round (suma-cos-abs 25)) (exact-round -0.12553272081882738)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-abstracta-rango f i j) #f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-cuadrados-rango i j)
  (suma-abstracta-rango sqr i (- j 1)))

(module+ test
  (check-equal? (suma-cuadrados-rango 0 1) 0)
  (check-equal? (suma-cuadrados-rango 1 2) 1)
  (check-equal? (suma-cuadrados-rango 1 3) 5)
  (check-property (property ([k arbitrary-natural])
                            (= (suma-cuadrados-rango 1 (+ k 1))
                               (/ (* k (+ k 1) (+ (* 2 k ) 1)) 6))))
  (check-property (property ([k arbitrary-natural])
                            (= (suma-cuadrados-rango 1 (+ k 1))
                               (+ (suma-cuadrados-rango 1 k)
                                  (suma-cuadrados-rango k (+ k 1)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-cos-rango i j) #f)  

(module+ test
  (check-equal? (suma-cos-rango 0 0) 0)
  (check-equal? (exact-round (suma-cos-rango 1 2)) (exact-round 0.5403023058681398))
  (check-equal? (exact-round (suma-cos-rango 1 3)) (exact-round 0.12415546932099736))
  (check-equal? (exact-round (suma-cos-rango 1 4)) (exact-round -0.865837027279448))
  (check-equal? (exact-round (suma-cos-rango 1 6)) (exact-round -1.2358184626798336))
  (check-equal? (exact-round (suma-cos-rango 1 11)) (exact-round -1.4174477464559059))
  (check-equal? (exact-round (suma-cos-rango 1 16)) (exact-round -0.28467200293615436))
  (check-equal? (exact-round (suma-cos-rango 1 21)) (exact-round 0.5396085669330053))
  (check-equal? (exact-round (suma-cos-rango 1 26)) (exact-round -0.12553272081882738)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (suma-abstracta-rango-paso f i j p) #f)

(module+ test
  (check-equal? (suma-abstracta-rango-paso identity 0 0 1) 0)
  (check-equal? (suma-abstracta-rango-paso identity 1 1 1) 1)
  (check-equal? (suma-abstracta-rango-paso identity 1 2 1) 3)
  (check-property (property ([k arbitrary-natural])
                            (= (suma-abstracta-rango-paso identity 1 k 1)
                               (/ (* k (+ k 1)) 2))))
  (check-equal? (suma-abstracta-rango-paso identity 1 10 2) (+ 1 3 5 7 9))
  (check-equal? (suma-abstracta-rango-paso identity 1 10 3) (+ 1 4 7 10)))
