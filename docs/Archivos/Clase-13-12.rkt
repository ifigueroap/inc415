#lang play

;; <F1WAE> ::= <numero>
;;         | <id>
;;         | <F1WAE> + <F1WAE>
;;         | with {<id> <F1WAE>} <F1WAE>


(deftype F1WAE ;; with + arithmetic expressions
  (w-num n)
  (w-id x)
  (w-add l r)
  (w-sub l r)
  (w-with name named-expr body)
  (w-app fun-name arg)
  (w-if c t e))

;; '{with {

;; parse :: s-expr -> Expr
(define (parse-wae s)
  (cond
    [(number? s) (w-num s)]    
    [(list? s)
     (match (first s)
       ['+ (w-add (parse-wae (second s))
                  (parse-wae (third s)))]
       ['- (w-sub (parse-wae (second s))
                  (parse-wae (third s)))]
       ['with (w-with (first (second s))
                      (parse-wae
                       (second (second s)))
                      (parse-wae (third s)))]
       ['if {w-if (parse-wae (second s))
                  (parse-wae (third s))
                  (parse-wae (fourth s))}]
       [else (w-app (first s) (parse-wae (second s)) )])]    
    [else (w-id s)]))

(define (interp-wae expr funs)
  (match expr
    [(w-num n) n]
    [(w-add l r) (+ (interp-wae l funs) (interp-wae r funs))]
    [(w-sub l r) (- (interp-wae l funs) (interp-wae r funs))]
    [(w-id x) (error "Identificador no definido")]
    [(w-if c t e)
     (if (= 0 (interp-wae c funs))
         (interp-wae t funs)
         (interp-wae e funs))]     
    [(w-with name named-expr body)
     (interp-wae
      (subst body name (w-num (interp-wae named-expr funs))) funs)]
    [(w-app fun-name arg)
     ;; 1: encontrar la definición asociado a la funcion, si existe.
     (let ([def-fun (assoc fun-name funs)])
       (if def-fun
           ;; 2: obtener el nombre del parametro formal de la funcion
           ;; 3: obtener el cuerpo de la función como AST
           (let ([arg-name (first (second def-fun))]
                 [fun-body (parse-wae (third def-fun))])
             ;; 4: interpreto el cuerpo de la funcion substituyendo
             ;; su parámetro formal por el valor del argumento específico
             ;; con el que se está invocando
             (interp-wae
              (subst fun-body arg-name (w-num (interp-wae arg funs)))
              funs))
           (error "funcion no encontrada" fun-name)))]))



;; subst :: WAE, symbol, valor -> WAE
(define (subst body name named-value)
  (match body
    [(w-num n) (w-num n)]
    [(w-add l r) (w-add (subst l name named-value)
                        (subst r name named-value))]
    [(w-sub l r) (w-sub (subst l name named-value)
                        (subst r name named-value))]
    [(w-id x)
     (if (equal? x name)
         named-value
         (w-id x))]
    [(w-if c t e) (w-if (subst c name named-value)
                        (subst t name named-value)
                        (subst e name named-value))]
    [(w-with name2 named-expr2 body2)
     (if (equal? name2 name)
         (w-with name2
                 (subst named-expr2 name named-value)
                 ;; el cuerpo queda igual porque el with introduce el mismo
                 ;; nombre que el de esta substitucion
                 body2)
         (w-with name2
                 (subst named-expr2 name named-value)
                 ;; en el cuerpo substituyo porque el segundo with
                 ;; introduce otro nombre, distinto al de esta substitucion
                 (subst body2 name named-value)))]
    [(w-app fun-name arg) (w-app fun-name (subst arg name named-value))]))

;; En Racket se introducen identificadores usando... let

#|
(define p5* 'x)

(define p5** '{with {x 1} x})
(subst (w-id 'x) 'x (w-num 1))

(define p5 '{with {x {+ 5 5}} {+ x x}})
(subst (w-add (w-id 'x) (w-id 'x))
       'x
       (w-add (w-num 5) (w-num 5)))

(define p5r (let ((x (+ 5 5))) (+ x x)))

(define p6 '{with {x {+ 5 5}}
                  {with {y {+ x 1}} {+ x y}}})

(define p6r (let ((x (+ 5 5)))
              (let ((y (+ x 1)))
                (+ x y))))

(define p7 '{with {x {+ 5 5}}
                  {with {x 1}
                        {+ x x}}})

(check (interp-wae (parse-wae p5**)) 1)
(check (interp-wae (parse-wae p5)) 20)
(check (interp-wae (parse-wae p6)) 21)
(check (interp-wae (parse-wae p7)) 2)
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define pf1 '{with {x 3} {sumar1 x}})

(define funciones '{{sumar1 {z} {+ z 1}}})

(define funciones2 '{{sumar1 {wasdasd} {+ wasdasd 1100}}})

;; Se cae
;; (interp-wae (parse-wae pf1) '())

(interp-wae (parse-wae pf1) funciones)

(interp-wae (parse-wae pf1) funciones2)

(interp-wae (parse-wae '{+ {sumar1 1} {sumar1 3}}) funciones)

;; las funciones pueden "verse" a sí mismas
;; y también a las otras que están definidas
;; las definiciones de funciones son "globales"
(define funciones3 '{{hola {x} {chao {+ x 1}}} {chao {y} {+ y 15}}})
(interp-wae (parse-wae '{+ {hola 1} {hola 2}}) funciones3)

(define funciones4 '{{sumanacii {x} {if x 0 {+ x {sumanacii {- x 1}}}}}})
(interp-wae (parse-wae '{sumanacii 5}) funciones4)

;(interp-wae (parse-wae '{first {cons 1 2 3}}) '())
