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
       
       [whitespace (token 'WS lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start) #:skip? #t)]
       
       ["{" (token 'PROG-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["}" (token 'PROG-STOP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["$" (token 'DOLLAR lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["read" (token 'READ lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["write" (token 'WRITE lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [";" (token 'DELIMIT lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["if (" (token 'COND-START lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [")" (token 'COND-STOP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       ["=" (token 'ASSIGN-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["+" (token 'ADD-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       ["-" (token 'SUB-OP lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [(:+ (:or lower-letter upper-letter)) (token 'ID lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       [(:+ digit) (token 'DIGIT (string->number lexeme) #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]
       
       [any-char (token 'MISC lexeme #:position (+ (pos lexeme-start)) #:line (line lexeme-start))]))
    (odai-lexer port))
  next-token)

(provide make-tokenizer)
