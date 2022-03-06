#lang br/quicklang
(require brag/support)

(define (make-tokenizer port)
  (port-count-lines! port) ; get line data
  (define (next-token)
    (define-lex-abbrevs
      (lower-letter (:/ "a" "z"))
      (upper-letter (:/ #\A #\Z))
      (digit (:/ "0" "9")))
    (define odai-lexer
      (lexer
       #|[(from/to "//" "\n") (next-token)] ; comment
       [(from/to "@$" "$@")
        (token 'SEXP-TOK (trim-ends "@$" lexeme "$@"))]|#
       ["{" (token 'START lexeme #:skip? #t)]
       ["} $$" (token 'END lexeme #:skip? #t)]
       ["read" (token 'READ lexeme #:skip? #t)]
       [";" (token 'DELIMIT lexeme #:skip? #t)]
       ;[whitespace 'WS]
       [whitespace (token 'WS lexeme #:skip? #t)]
       ;[whitespace (token #:skip? #t)]
       ["\n" 'NEWLINE]
       [(:+ (:or lower-letter upper-letter)) (token 'ID #|string->symbol|# lexeme
                                                    #:position (+ (pos lexeme-start))
                                                    #:line (line lexeme-start)
                                                    #:column (+ (col lexeme-start))
                                                    #:span (- (pos lexeme-end)
                                                              (pos lexeme-start)))]
       [(:+ digit) (token 'DIGIT (string->number lexeme))]
       ;[whitespace (token 'WHITESPACE lexeme #:skip? #t)]
       [any-char (token 'MISC lexeme
                        #:position (pos lexeme-start)
                        #:line (line lexeme-start)
                        #:column (col lexeme-start)
                        #:span (- (pos lexeme-end)
                                  (pos lexeme-start)))]))
    (odai-lexer port))
  next-token)
(provide make-tokenizer)
