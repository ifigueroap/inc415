#lang racket

(define (add1 n)
  (+ n 1))

(define (add2 n)
  (+ n 2))

(define (add3 n)
  (+ n 3))

(define (add-abstracto m)
  
  (define (nuevo-add n)
    (+ m n))
  
  nuevo-add)

(define add1* (add-abstracto 1))
(define add2* (add-abstracto 2))
(define add3* (add-abstracto 3))


(define my-list '(1 2 3 4 5))

(define (cuadrados-lista l)
  (cond
    [(empty? l) '()]
    [else
     (cons (sqr (first l))
           (cuadrados-lista
            (rest l)))]))

(define (cosenos-lista l)
  (cond
    [(empty? l) '()]
    [else
     (cons (cos (first l))
           (cosenos-lista
            (rest l)))]))

(define (sqrt-lista l)
  (cond
    [(empty? l) '()]
    [else
     (cons (sqrt (first l))
           (sqrt-lista
            (rest l)))]))


(define (transformar-lista l op)
  (cond
    [(empty? l) '()]
    [else
     (cons (op (first l))
           (transformar-lista
            (rest l) op))]))

(define (cuadrados-lista* l)
  (transformar-lista l sqr))

(define (cosenos-lista* l)
  (transformar-lista l cos))

(define (sqrt-lista* l)
  (transformar-lista l sqrt))

(define (elementos-pares l)
  (cond
    [(empty? l) '()]
    [else
     (let ([h (first l)])
       (if (even? h)
           (cons h (elementos-pares (rest l)))
           (elementos-pares (rest l))))]))

(define (elementos-impares l)
  (cond
    [(empty? l) '()]
    [else
     (let ([h (first l)])
       (if (odd? h)
           (cons h (elementos-impares (rest l)))
           (elementos-impares (rest l))))]))

(define (mayor-que-3? n)
  (> n 3))

(define (elementos-mayores-que-3 l)
  (cond
    [(empty? l) '()]
    [else
     (let ([h (first l)])
       (if (mayor-que-3? h)
           (cons h (elementos-mayores-que-3 (rest l)))
           (elementos-mayores-que-3 (rest l))))]))


(define (elementos-que-cumplen-un-predicado l pred)
  (cond
    [(empty? l) '()]
    [else
     (let ([h (first l)])
       (if (pred h)
           (cons h (elementos-que-cumplen-un-predicado (rest l) pred))
           (elementos-que-cumplen-un-predicado (rest l) pred)))]))


(define (elementos-pares* l)
  (elementos-que-cumplen-un-predicado l even?))

(define (elementos-impares* l)
  (elementos-que-cumplen-un-predicado l odd?))

(define (elementos-mayores-que-3* l)
  (elementos-que-cumplen-un-predicado l mayor-que-3?))

(define (factorial n)
  (cond
    [(= n 0) 1]
    [else (* n (factorial (- n 1)))]))

(define (primeros-k-factoriales k)
  (map factorial (range 1 (+ k 1))))

(define (primeros-k-factoriales->-50 k)
  (filter (λ (x) (> x 50)) (map factorial (range 1 (+ k 1)))))



(define (reject l p)
  (filter (lambda (x) (not (p x))) l )
)
(define (split l pred)
  (list
   (filter (λ (x) (not (pred x))) l)
   (filter (λ (x) (pred x)) l)))

(define (split* l pred)
  (list
   (reject l pred)
   (filter pred l)))









