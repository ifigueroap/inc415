#lang play

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

;; Environment
(deftype Env
  (mtEnv)
  (anEnv name value env))

(define (extend-env name value env)
  (anEnv name value env))

(define (empty-env)
  (mtEnv))

(define (lookup-env name env)
  (match env
    [(mtEnv) (error "Identificador no encontrado")]
    [(anEnv n v e)
     (if (equal? name n)
         v
         (lookup-env name e))]))
     

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
     
(define (interp-wae expr env)
  (match expr
    [(w-num n) n]
    [(w-add l r) (+ (interp-wae l env) (interp-wae r env))]
    [(w-id x) (lookup-env x env)]
    [(w-with name named-expr body)
     (interp-wae body
                 (extend-env name
                             (interp-wae named-expr env)
                             env))]))
    
;; En Racket se introducen identificadores usando... let

(define p5* 'x)

(define p5** '{with {x 1} x})

(define p5 '{with {x {+ 5 5}} {+ x x}})


(define p5r (let ((x (+ 5 5))) (+ x x)))

(define p6 '{with {x {+ 5 5}}
                  {with {y {+ x 1}} {+ x y}}})

(define p6r (let ((x (+ 5 5)))
              (let ((y (+ x 1)))
                (+ x y))))

(define p7 '{with {x {+ 5 5}}
                  {with {x 1}
                        {+ x x}}})

(check (interp-wae (parse-wae p5**) (empty-env)) 1)
(check (interp-wae (parse-wae p5) (empty-env)) 20)
(check (interp-wae (parse-wae p6) (empty-env)) 21)
(check (interp-wae (parse-wae p7) (empty-env)) 2)










