#lang play

;; Debe actualizar/reinstallar el package play
;; En su instalación de DrRacket para usar
;; la nueva libreria play/parsers
;;
;; - Los operadores para expresiones regulares
;; usan @ como prefijo.
;;
;; - La función consume-lexer viene predefinida en la librería.
;; Invoca al lexer sobre el flujo de entrada hasta llegar al final.
;; Los resultados son acumulados en una lista.
;;
;; - La expresion define-lexer permite definir lexers de manera
;; un poquito mas concisa.

(require play/parsers)

;; Ejemplo: lexer que reconoce los digitos y las letras

(define-lex-abbrev letra (@or (char-range #\a #\z) (char-range #\A #\Z)))
(define-lex-abbrev digito (char-range #\0 #\9))

;;;; LEXER EJEMPLO

(define-lexer lex-letra-digito
  [#\newline (lex-letra-digito input-port)]
  [#\space (lex-letra-digito input-port)]
  [letra "letra"]
  [digito "digito"])

(check (consume-lexer lex-letra-digito (open-input-string "abc\n def135\n\n435 bb"))
       (list "letra" "letra" "letra" "letra" "letra" "letra" "digito" "digito" "digito" "digito" "digito" "digito" "letra" "letra"))


;;;; LEXER 1: identificadores válidos del lenguaje C

(define-lexer lex-id-c
  [any-char "foo"])

(check (consume-lexer lex-id-c (open-input-string "a")) (list "a"))
(check/exn (consume-lexer lex-id-c (open-input-string "1")) "")
(check/exn (consume-lexer (lex-id-c (open-input-string "_"))) "")
(check (consume-lexer lex-id-c (open-input-string "   a_1\n a2_ a__b_2")) (list "a_1" "a2_" "a__b_2"))
(check (consume-lexer lex-id-c (open-input-string "   a2_  \n\n  ")) (list "a2_"))
(check (consume-lexer lex-id-c (open-input-string "a2_343490")) (list "a2_343490"))
(check (consume-lexer lex-id-c (open-input-string "a2_ b_343490")) (list "a2_" "b_343490"))


;;;; LEXER 2: numeros enteros, en base decimal, que pueden ser positivos o negativos.

(define-lexer lex-integers
  [any-char "foo"])

(check (consume-lexer lex-integers (open-input-string "0")) (list "0"))
(check (consume-lexer lex-integers (open-input-string "1")) (list "1"))
(check (consume-lexer lex-integers (open-input-string "2")) (list "2"))
(check (consume-lexer lex-integers (open-input-string "3")) (list "3"))
(check (consume-lexer lex-integers (open-input-string "4")) (list "4"))
(check (consume-lexer lex-integers (open-input-string "5")) (list "5"))
(check (consume-lexer lex-integers (open-input-string "6")) (list "6"))
(check (consume-lexer lex-integers (open-input-string "7")) (list "7"))
(check (consume-lexer lex-integers (open-input-string "8")) (list "8"))
(check (consume-lexer lex-integers (open-input-string "9")) (list "9"))

(check (consume-lexer lex-integers (open-input-string "-1")) (list "-1"))
(check (consume-lexer lex-integers (open-input-string "-2")) (list "-2"))
(check (consume-lexer lex-integers (open-input-string "-3")) (list "-3"))
(check (consume-lexer lex-integers (open-input-string "-4")) (list "-4"))
(check (consume-lexer lex-integers (open-input-string "-5")) (list "-5"))
(check (consume-lexer lex-integers (open-input-string "-6")) (list "-6"))
(check (consume-lexer lex-integers (open-input-string "-7")) (list "-7"))
(check (consume-lexer lex-integers (open-input-string "-8")) (list "-8"))
(check (consume-lexer lex-integers (open-input-string "-9")) (list "-9"))

(check (consume-lexer lex-integers (open-input-string "0123")) (list "0" "123"))

(check (consume-lexer lex-integers (open-input-string "1 2 3 4 5 6 7 8 9"))
       (list "1" "2" "3" "4" "5" "6" "7" "8" "9"))

(check (consume-lexer lex-integers (open-input-string "-1 -2 -3 -4 -5 -6 -7 -8 -9"))
       (list "-1" "-2" "-3" "-4" "-5" "-6" "-7" "-8" "-9"))

(check (consume-lexer lex-integers (open-input-string "-11 21 -30 42 -53 68 -79 86 -9123"))
       (list "-11" "21" "-30" "42" "-53" "68" "-79" "86" "-9123"))


;;;; LEXER 3: numeros enteros, en base octal, que pueden ser positivos o negativos.

(define-lexer lex-octal-integers
  [any-char "foo"])

(check (consume-lexer lex-octal-integers (open-input-string "0x0")) (list "0x0"))
(check (consume-lexer lex-octal-integers (open-input-string "0x1")) (list "0x1"))
(check (consume-lexer lex-octal-integers (open-input-string "0x2")) (list "0x2"))
(check (consume-lexer lex-octal-integers (open-input-string "0x3")) (list "0x3"))
(check (consume-lexer lex-octal-integers (open-input-string "0x4")) (list "0x4"))
(check (consume-lexer lex-octal-integers (open-input-string "0x5")) (list "0x5"))
(check (consume-lexer lex-octal-integers (open-input-string "0x6")) (list "0x6"))
(check (consume-lexer lex-octal-integers (open-input-string "0x7")) (list "0x7"))

(check/exn (consume-lexer lex-octal-integers (open-input-string "0x8")) "")
(check/exn (consume-lexer lex-octal-integers (open-input-string "0x9")) "")

(check (consume-lexer lex-octal-integers (open-input-string "-0x0")) (list "-0x0"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x1")) (list "-0x1"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x2")) (list "-0x2"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x3")) (list "-0x3"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x4")) (list "-0x4"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x5")) (list "-0x5"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x6")) (list "-0x6"))
(check (consume-lexer lex-octal-integers (open-input-string "-0x7")) (list "-0x7"))

(check/exn (consume-lexer lex-octal-integers (open-input-string "-0x8")) "")
(check/exn (consume-lexer lex-octal-integers (open-input-string "-0x9")) "")

(check (consume-lexer lex-octal-integers (open-input-string "0x0123")) (list "0x0123"))

(check (consume-lexer lex-octal-integers (open-input-string "-0x11 0x21 -0x30 0x42 -0x53 0x66 -0x77 0x16 -0x7123"))
       (list "-0x11" "0x21" "-0x30" "0x42" "-0x53" "0x66" "-0x77" "0x16" "-0x7123"))


;;;; LEXER 4: numeros reales, positivos y negativos, en notacion normal o científica

(define-lexer lex-real-numbers
  [any-char "foo"])

(check (consume-lexer lex-real-numbers (open-input-string "0.0000")) (list "0.0000"))
(check (consume-lexer lex-real-numbers (open-input-string "-3.14")) (list "-3.14"))
(check (consume-lexer lex-real-numbers (open-input-string "0.000314")) (list "0.000314"))
(check (consume-lexer lex-real-numbers (open-input-string "4.12e-4")) (list "4.12e-4"))
(check (consume-lexer lex-real-numbers (open-input-string "4.12E-4")) (list "4.12E-4"))
(check (consume-lexer lex-real-numbers (open-input-string "-5.78e-300")) (list "-5.78e-300"))
(check (consume-lexer lex-real-numbers (open-input-string "4.12E42")) (list "4.12E42"))
(check (consume-lexer lex-real-numbers (open-input-string "-12E42")) (list "-12E42"))
(check (consume-lexer lex-real-numbers (open-input-string "-1234")) (list "-1234"))
(check (consume-lexer lex-real-numbers (open-input-string "1234")) (list "1234"))
(check (consume-lexer lex-real-numbers (open-input-string "0 1 -3 -3.14 2.15 3.2e-9"))
       (list "0" "1" "-3" "-3.14" "2.15" "3.2e-9"))


;;;; LEXER 5: cadenas ASCII que comienzan con letra mayúscula y las demas son minúsculas

(define-lexer lex-ascii-capital-strings
  [any-char "foo"])

(check/exn (consume-lexer lex-ascii-capital-strings (open-input-string "hola")) "")
(check/exn (consume-lexer lex-ascii-capital-strings (open-input-string "HOLA")) "")
(check/exn (consume-lexer lex-ascii-capital-strings (open-input-string "hOLA")) "")
(check/exn (consume-lexer lex-ascii-capital-strings (open-input-string "Hola1")) "")
(check/exn (consume-lexer lex-ascii-capital-strings (open-input-string "H0la1")) "")
(check (consume-lexer lex-ascii-capital-strings (open-input-string "Hola")) (list "Hola"))
(check (consume-lexer lex-ascii-capital-strings (open-input-string "Hola Mundo")) (list "Hola" "Mundo"))
(check/exn (consume-lexer lex-ascii-capital-strings (open-input-string "Hola mundo")) "")

