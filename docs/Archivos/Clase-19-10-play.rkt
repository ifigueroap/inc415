#lang play

;; Tests sencillos de igualdad
(test 1 1)
;(test (+ 0 1) 2)

;; Testear excepciones
(define (mysqrt x)
  (if (and (number? x) (positive? x))
      (sqrt x)
      (error "el numero debe ser positivo")))

(test (mysqrt 4) 2)
(test/exn (mysqrt -1) "")

;; Definir mis propias estructuras inductivas!! yajuuuuu :-)
;; usando: deftype 

(deftype ArbolBinario ;; predicado: 'ArbolBinario?'
  ;; constructor: 'hoja', accesor: 'hoja-valor', predicado: 'hoja?'
  (hoja valor)
  ;; constructor: 'nodo', accesores: 'nodo-valor', 'nodo-hijo-izq', 'nodo-hijo-der'
  ;; predicado: 'nodo?'
  (nodo valor hijo-izq hijo-der)) 

(define arbol1
  (nodo 1 (hoja 2) (nodo 3 (hoja 0) (hoja 4))))

;; Suma los numeros de un arbol cuyos valores son solamente numeros
;; ArbolBinario[numeros] -> numero
(define (suma-arbol ab)
  (match ab
    [(hoja valor) valor]
    [(nodo valor hijo-izq hijo-der)
     (+ valor (suma-arbol hijo-izq) (suma-arbol hijo-der))]))    


(test (suma-arbol (hoja 1)) 1)
(test (suma-arbol (hoja 0)) 0)
(test (suma-arbol (hoja 343434)) 343434)
(test (suma-arbol (nodo 1 (hoja 2) (hoja 3))) 6)
(test (suma-arbol arbol1) 10)

(define hoja1 (hoja 32328))

;; Accesores
(match hoja1 [(hoja v) v])

(hoja-valor hoja1)

(nodo-hijo-izq arbol1)
(hoja 2)
(nodo-hijo-der arbol1)
(nodo-valor arbol1)

;; Predicados
(ArbolBinario? 1)
(ArbolBinario? '(1 2 3))
(ArbolBinario? hoja1)
(ArbolBinario? arbol1)
(hoja? hoja1)
(hoja? arbol1)
(hoja? 1)
(nodo? hoja1)
(nodo? arbol1)
(nodo? 1)

;; CALCULADORA ----> LENGUAJE DE EXPRESIONES ARITMETICAS

;; <Expr> ::= (num n)
;;          | (add <expr1> <expr2>)

(deftype Expr
  (num n)
  (add expr1 expr2))

(define p1 (num 1))
(define p2 (add (num 1) (num 2)))
(define p3 (add (add (num 1) (num 2)) (num 3)))


;; calc: Expr -> Numero-Racket
(define (calc e)
  (match e
    [(num n) n]
    
    [(add expr1 expr2)     
     (+ (calc expr1) (calc expr2))

     ]))    

(test (calc p1) 1)
(test (calc p2) 3)
(test (calc p3) 6)

|#
Sintaxis concreta ---->
1 + 2 + (4 + 5)   ----> Sintaxis abstracta
                 ¿como?
         Analisis lexico y gramatico
#|












