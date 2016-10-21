#lang racket

(require parser-tools/lex)

;; Reconoce R.E= a|b

;; ab-lexer : input-port -> any
(define ab-lexer
  (lexer
   [#\a (display "Hola A\n")]
   [#\b (display "Hola B\n")]

   ;; parametro implicito 'input-port'
   ;; representa el port donde se esta
   ;; consumiento la entrada
   ;; la llamada recursiva indica que
   ;; el lexer debe continuar procesando
   [#\space (ab-lexer input-port)]))

(define ab-test (open-input-string "a"))
(define ab-test2 (open-input-string "ab"))
(define ab-test3 (open-input-string "a          b"))


(define char-lexer
  (lexer
   [#\space (char-lexer input-port)]
   [#\newline (char-lexer input-port)]
   ;; lexeme: es la subcadena que
   ;; calzó efectivamente con el patrón
   [any-char (list 'CHAR lexeme)]))

(define cl1 (open-input-string "hola mundo perro abuelita"))

(define (consume-lexer l input)
  (match (l input)
    ['eof '()]
    [token (cons token (consume-lexer l input))]))
   

;;(consume-lexer char-lexer cl1)


;; letra := [a-zA-Z]
;; digito := [0-9]
;; alphanum := [letra|digito]+
;;
;; palabra := [letra]+
;;

;; Redefine simbolos comunes como el '+'
;(require parser-tools/lex-sre)

;; prefix-in renombra los simbolos y les pega un ':' antes
(require (prefix-in : parser-tools/lex-sre))

;; (:+ 1 2) vs (+ 1 2)

;; letra := [a-zA-Z]
(define-lex-abbrev letra (:or (char-range #\a #\z) (char-range #\A #\Z)))

;; palabra := [letra]+
(define-lex-abbrev palabra (:+ letra))

(define word-lexer
  (lexer
   [#\space (word-lexer input-port)]
   [#\newline (word-lexer input-port)]
   [palabra (list 'WORD lexeme)]))

(consume-lexer word-lexer cl1)

(define cl2 (open-input-string "hola mundo perro abuelita"))

(consume-lexer char-lexer cl2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-tokens a (NUM))
(define-empty-tokens b (ADD))

;; digito := [0-9]
(define-lex-abbrev digito (char-range #\0 #\9))

;; digito := [0-9]
(define-lex-abbrev digito_no_zero (char-range #\1 #\9))

;; digito := [0-9]
(define-lex-abbrev natural (:: digito_no_zero (:* digito)))

(define calc-lexer
  (lexer
   [natural (token-NUM (string->number lexeme))]
   ["+" (token-ADD)]
   [#\space (calc-lexer input-port)]))


(define p1-calc (open-input-string "1+2"))
(define p2-calc (open-input-string "1     + 2"))
(define p3-calc (open-input-string "1 2 + + + + 1 1 2 4956 + 1"))
  
(consume-lexer calc-lexer p1-calc)
(consume-lexer calc-lexer p2-calc)
(consume-lexer calc-lexer p3-calc)

