#lang play

;; Calculadora
;;
;; <expr> ::= <numero>
;;         | <expr> + <expr>
;;         | <expr> - <expr>
;;         | <expr> * <expr>
;;         | <expr> / <expr>
;;         | <expr> ^ <expr>

(deftype Expr
  (num n)
  (add l r)
  (sub l r)
  (mult l r)
  (div l r)
  (pow b e))

(define p1 (num 1))
(define p2 (add (num 1) (num 2)))
(define p3 (sub (add (num 1) (num 3)) (num 10)))

(define (calc expr)
  (match expr
    [(num n) n]
    [(add l r) (+ (calc l) (calc r))]
    [(sub l r) (- (calc l) (calc r))]
    [(mult l r) (* (calc l) (calc r))]
    [(div l r) (/ (calc l) (calc r))]
    [(pow b e) (expt (calc b) (calc e))]))


(define p1* '1)
(define p2* '{+ 1 2})
(define p3* '{- {+ 1 3} 10})

;; parse :: s-expr -> Expr
(define (parse-calc s)
  (cond
    [(number? s) (num s)]
    [(list? s)
     (match (first s)
       ['+ (add (parse-calc (second s))
                (parse-calc (third s)))]
       ['- (sub (parse-calc (second s))
                (parse-calc (third s)))]
       ['* (mult (parse-calc (second s))
                 (parse-calc (third s)))]
       ['/ (div (parse-calc (second s))
                (parse-calc (third s)))]
       ['^ (pow (parse-calc (second s))
                (parse-calc (third s)))])]))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define p4 '{+ {+ 5 5} {+ 5 5}})


;;;;; Agregar IDENTIFICADORES

;; <WAE> ::= <numero>
;;         | <id>
;;         | <WAE> + <WAE>
;;         | with {<id> <WAE>} <WAE>


(deftype WAE ;; with + arithmetic expressions
  (w-num n)
  (w-id x)
  (w-add l r)
  (w-with name named-expr body))

;; '{with {

;; parse :: s-expr -> Expr
(define (parse-wae s)
  (cond
    [(number? s) (w-num s)]
    [(list? s)
     (match (first s)
       ['+ (w-add (parse-wae (second s))
                  (parse-wae (third s)))]
       ['with (w-with (first (second s))
                      (parse-wae
                       (second (second s)))
                      (parse-wae (third s)))])]
    [else (w-id s)]))
     
(define (interp-wae expr)
  (match expr
    [(w-num n) n]
    [(w-add l r) (+ (interp-wae l) (interp-wae r))]
    [(w-id x) (error "Identificador no definido")]
    [(w-with name named-expr body)
     (interp-wae
      (subst body name (w-num (interp-wae named-expr))))]))


;; subst :: WAE, symbol, valor -> WAE
(define (subst body name named-value)
  (match body
    [(w-num n) (w-num n)]
    [(w-add l r) (w-add (subst l name named-value)
                        (subst r name named-value))]
    [(w-id x)
     (if (equal? x name)
         named-value
         body)]
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
                 (subst body2 name named-value)))]))

  ;; En Racket se introducen identificadores usando... let

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










