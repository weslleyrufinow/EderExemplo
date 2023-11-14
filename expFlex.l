%{
#include <stdlib.h>
#define YY_DECL int yylex()
#include "expBison.tab.h"
%}

int [0-9]+
real [0-9]+\.[0-9]+

%%

[ \t]           {;}//ignorar
\n              {return T_NEWLINE;} 
{int}           {yylval.ival = atoi(yytext); return T_INT;}
{real}          {yylval.fval = atof(yytext); return T_FLOAT;}
"+"             {return T_SUM;}
"-"             {return T_SUB;}
"*"             {return T_MULT;}
"/"             {return T_DIV;}
"("             {return T_LPAR;}
")"             {return T_RPAR;}
"sair"          {return T_EXIT;}
"exit"          {return T_EXIT;}


%%

