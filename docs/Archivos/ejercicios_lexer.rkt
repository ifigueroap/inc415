#lang play

(require parser-tools/lex)
(require (prefix-in @ parser-tools/lex-sre))

(define (consume-lexer l input)
  (match (l input)
    ['eof '()]
    [token (cons token (consume-lexer l input))]))

(define-lex-abbrev digito (char-range #\0 #\9))
(define-lex-abbrev letra (@or (char-range #\a #\z) (char-range #\A #\Z)))
(define-lex-abbrev identificador-c (@: letra (@* (@or letra digito #\_))))

(define lex-id-c
  (lexer
   [#\newline (lex-id-c input-port)]
   [#\space (lex-id-c input-port)]
   [identificador-c (list "acepta" lexeme)]))

(test (lex-id-c (open-input-string "a")) (list "acepta" "a"))
(test/exn (lex-id-c (open-input-string "1")) "")
(test/exn (lex-id-c (open-input-string "_")) "")
(test (lex-id-c (open-input-string "a2_")) (list "acepta" "a2_"))
(test (lex-id-c (open-input-string "   a2_    ")) (list "acepta" "a2_"))
(test (lex-id-c (open-input-string "a2_343490")) (list "acepta" "a2_343490"))
(test (consume-lexer lex-id-c (open-input-string "a2_ b_343490"))
      (list (list "acepta" "a2_") (list "acepta" "b_343490")))

(define ejemplo (open-input-string "a2_343490"))
(define ejemplo2 (open-input-string "a2 b343490")) 















