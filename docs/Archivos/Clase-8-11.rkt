#lang play

(require play/parsers)

;; Genera el constructor 'token-NUM'
;; Para construir el token correspondiente
(define-tokens a (NUM))

;; Genera los constructores 'token-ADD' y 'token-EOF'
;; Para construir los tokens correspondientes
(define-empty-tokens b (ADD REST EOF))

(define-lexer calculadora-lexer  
  ["+" (token-ADD)]
  ["-" (token-REST)]
  [numeric (token-NUM lexeme)]
  [(eof) (token-EOF)])

(define-lexer calculadora-lexer2
  [whitespace (calculadora-lexer input-port)]
  ["+" (token-ADD)]
  [numeric (token-NUM lexeme)]
  [(eof) (token-EOF)])

(define-parser calculadora-parser
  (grammar
   ;;
   ;; [ <no-terminal> ( [lado derecho definicion de <no-terminal>] action )+ ]
   [<S> ([<E>]         '())]
   [<E> ([NUM]         '())
        ([<E> ADD <E>] '())
        ([<E> REST <E>] '())])
  
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
(define ejemplo5 "1-1")

(parse "1" with-parser calculadora-parser and-lexer calculadora-lexer)



