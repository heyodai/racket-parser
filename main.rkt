#lang br
(require "parser.rkt" "tokenizer.rkt" brag/support)

(define (parse file-name)
  (define file-content (port->string (open-input-file file-name) #:close? #t))
  (display "test\n")
  
  ;(apply-tokenizer-maker make-tokenizer in)
  ;(parse-to-datum (apply-tokenizer-maker make-tokenizer in))

  (if (list? (parse-to-datum (apply-tokenizer-maker make-tokenizer file-content)))
      (display "pass")
      (display "fail")
      )
  )

(parse "input1.txt")
