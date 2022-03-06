#lang brag

program : PROG-START stmt_list PROG-STOP DOLLAR DOLLAR
stmt_list : stmt [stmt_list]*
stmt : ID ASSIGN-OP expr DELIMIT ; id = expr;
     | COND-START expr COND-STOP stmt ; if (expr) stmt
     | READ ID DELIMIT ; read id;
     | WRITE expr DELIMIT ; write expr;

expr: (ID|DIGIT|numsign DIGIT) [numsign expr]* 
numsign : ADD-OP | SUB-OP | ""
