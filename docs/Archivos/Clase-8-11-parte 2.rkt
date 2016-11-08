#lang play

(require play/parsers)

;; Tipo de dato inductivo
;; que corresponde al AST/arbol de parseo
(deftype Expr
  (num n)
  (add l r)
  (sub l r))

;; calc: Expr -> Numero-Racket
(define (calc e)
  (match e
    [(num n) n]
    [(add expr1 expr2)
     (+ (calc expr1) (calc expr2))]
    [(sub expr1 expr2)
     (- (calc expr1) (calc expr2))]))

;;;;;;;;; ===================================================================

;; Genera el constructor 'token-NUM'
;; Para construir el token correspondiente
(define-tokens a (NUM))

;; Genera los constructores 'token-ADD' y 'token-EOF'
;; Para construir los tokens correspondientes
(define-empty-tokens b (ADD REST EOF))

(define-lexer calculadora-lexer
  [whitespace (calculadora-lexer input-port)]
  ["+" (token-ADD)]
  ["-" (token-REST)]
  [numeric (token-NUM (string->number lexeme))]
  [(eof) (token-EOF)])

(define-parser calculadora-parser
  (grammar
   ;;
   ;; [ <no-terminal> ( [lado derecho definicion de <no-terminal>] action )+ ]
   [<S> ([<E>]          $1)]
   [<E> ([NUM]          (num $1))
        ([<E> ADD <E>]  (add $1 $3))
        ([<E> REST <E>] (sub $1 $3))])       
  
  ;; simbolo inicial
  (start <S>)
  
  ;; simbolo final: <E>$.
  (end EOF)
  
  ;; Qué hacer en caso de error
  (error void)
  
  ;; Conjuntos de tokens
  (tokens a b)
  
  ;; ADD es asociativo hacia la izquierda: (left ADD)
  ;; También podría ser hacia la derecha: (right ADD)
  ;; También podría no tener precedencia/asociatividad: (none ADD)
  (precs (left ADD REST)))

(define ejemplo1 "1")
(define ejemplo2 "1+1")
(define ejemplo3 "1  +   1")
(define ejemplo4 "1 \n\n+  \n 1")

(parse "1" with-parser calculadora-parser and-lexer calculadora-lexer)

(define (calc-exec str)
  (calc (parse str with-parser calculadora-parser and-lexer calculadora-lexer)))

(check (calc-exec ejemplo1) 1)
(check (calc-exec ejemplo2) 2)
(check (calc-exec ejemplo3) 2)
(check (calc-exec ejemplo4) 2)

(define ejemplo5 "1-1")
(check (calc-exec ejemplo5) 0)
