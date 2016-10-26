#lang play

(require play/parsers)

(define-lex-abbrev digito (char-range #\0 #\9))
(define-lex-abbrev letra (@or (char-range #\a #\z) (char-range #\A #\Z)))
(define-lex-abbrev identificador-c (@: letra (@* (@or letra digito #\_))))

(define-lexer lex-id-c  
   [#\newline (lex-id-c input-port)]
   [#\space (lex-id-c input-port)]
   [identificador-c (list "acepta" lexeme)])

(check (lex-id-c (open-input-string "a")) (list "acepta" "a"))
(check/exn (lex-id-c (open-input-string "1")) "")
(check/exn (lex-id-c (open-input-string "_")) "")
(check (lex-id-c (open-input-string "a2_")) (list "acepta" "a2_"))
(check (lex-id-c (open-input-string "   a2_    ")) (list "acepta" "a2_"))
(check (lex-id-c (open-input-string "a2_343490")) (list "acepta" "a2_343490"))
(check (consume-lexer lex-id-c (open-input-string "a2_ b_343490"))
      (list (list "acepta" "a2_") (list "acepta" "b_343490")))

(define ejemplo (open-input-string "a2_343490"))
(define ejemplo2 (open-input-string "a2 b343490")) 















