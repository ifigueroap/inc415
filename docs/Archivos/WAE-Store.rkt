#lang play

(deftype WAE
  (w-num n)
  (w-id x)
  (w-set id expr)
  (w-add l r)
  (w-seq expr-list)
  (w-with name named-expr body))  
  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Environment: definiciones originales

(deftype Env
  (mtEnv)
  (anEnv name loc env))

(define (extend-env name loc env)
  (anEnv name loc env))

(define (empty-env)
  (mtEnv))

(define (lookup-env name env)
  (match env
    [(mtEnv) (error "Identificador no encontrado")]
    [(anEnv n loc e)
     (if (equal? name n)
         loc
         (lookup-env name e))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Store

(deftype Store
  (mtSto)
  (aSto loc value sto))

(define (next-loc sto)
  (match sto
    [(mtSto) 100]
    [(aSto loc v (mtSto)) (+ loc 10)]
    [(aSto loc v nextSto) (next-loc nextSto)]))  

(define (extend-sto loc value sto)
  (aSto loc value sto))

(define (lookup-sto loc sto)
  (match sto
    [(mtSto) (error "Ubicacion de memoria no encontrado")]
    [(aSto l v s)
     (if (equal? loc l)
         v
         (lookup-sto loc s))]))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lookup Identificador env y store
(define (lookup-value name env sto)
  (lookup-sto  (lookup-env name env) sto))  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Value x Store
(deftype ValueStore
  [v*s value store])

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
                      (parse-wae (third s)))]
       ['seq (w-seq (map parse-wae (rest s)))]
       ['set (w-set (second s) (parse-wae (third s)))])]
    [else (w-id s)]))

;; WAE -> ValueStore
(define (interp-wae expr env sto)
  (match expr
    [(w-num n) (v*s n sto)]
    [(w-with name named-expr body)
     (let ([vs-named-value (interp-wae named-expr env sto)])
       (match vs-named-value
         ([v*s named-value new-store]
          (let ([new-loc (next-loc new-store)])
            (interp-wae body (extend-env name new-loc env) (extend-sto new-loc named-value new-store))))))]

    ;; Por implementar
    [(w-id x) (error "Por implementar interp w-id")]
    [(w-add l r) (error "Por implementar interp w-add")]
    [(w-set x expr) (error "Por implementar interp w-set")]
    [(w-seq expr-list) (error "Por implementar interp w-seq")]    
    ))
     

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CASOS DE PRUEBA

(define (run-value prog)
  (v*s-value (interp-wae (parse-wae prog) (mtEnv) (mtSto))))

;; Programas sin mutación
;; 5 puntos
(check (run-value '{with {x 1} 1}) 1)

;; 5 puntos
(check (run-value '{with {x 1} {with {x {+ x x}} {+ x 1}}}) 3)

;; 10 puntos
(check (run-value '{with {x 1} {with {y {+ x x}} {+ x y}}}) 3)

;; 10 puntos
(check (run-value '{seq 1 2 3 4 5 6}) 6)

;; Programas con mutación

;; 10 puntos
(check (run-value '{with {x 1} {seq {set x 10} x}}) 10)

;; 15 puntos
(check (run-value '{with {x 1} {with {y {{seq {set x 5} {+ x x}}}} {+ x y}}}) 15)

;; 15 puntos
(check (run-value '{with {x 1} {with {x {{seq {set x 5} {+ x x}}}} {+ x x}}}) 20)

;; 30 puntos
(check (run-value '{with {x 1} {with {y 2} {+ {seq {set x 10} y} {seq {set y 99} x}}}}) 12)