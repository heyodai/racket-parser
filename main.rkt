#lang br
(require "grammar.rkt" "tokenizer.rkt" brag/support)

(define (parse file-name)
  (define file-content (port->string (open-input-file file-name) #:close? #t))
  (with-handlers ([exn:fail? (lambda (exn)
                               (displayln (exn-message exn)))])
  (parse-to-datum (apply-tokenizer-maker make-tokenizer file-content))
      (display "Accept")
  ))

(parse "input5.txt")
