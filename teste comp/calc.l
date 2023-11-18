%{
#include <stdio.h>
#include <stdlib.h>
#include "calc.tab.h"
%}

%%
[0-9]+        { yylval.ival = atoi(yytext); return T_INT; }
"+"           { return T_PLUS; }
"-"           { return T_MINUS; }
"*"           { return T_MULTIPLY; }
"/"           { return T_DIVIDE; }
"("           { return T_LPAREN; }
")"           { return T_RPAREN; }
\n            { return T_NEWLINE; }
[ \t]         ; // ignorar espaços em branco
.             { fprintf(stderr, "Caractere inesperado: %s\n", yytext); }
%%

int yywrap(){
    return 1;
}
