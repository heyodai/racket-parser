#lang br
(require "parser.rkt" "tokenizer.rkt" brag/support)

(define file-content (port->string (open-input-file "input3.txt") #:close? #t))
  
(apply-tokenizer-maker make-tokenizer file-content)
(parse-to-datum (apply-tokenizer-maker make-tokenizer file-content))
