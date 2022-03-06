#lang brag

;program : "{" stmt_list "} $$"
program : START stmt_list END | stmt_list
stmt_list : stmt stmt_list* | "" | ID
; stmt_list -> epsilon 
stmt : ID "=" expr DELIMIT | "if ("expr")" stmt | READ ID DELIMIT | "write" expr DELIMIT
expr: ID etail | num etail 
;etail: + expr | - expr | epsilon
etail: numsign expr | ""
;id : ["a-zA-Z"]+
num : numsign DIGIT DIGIT*
numsign : "+" | "-" | ""
;discard: WS | MISC ; whitespace
;digit    : "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
;digit : "[0-9]+"
