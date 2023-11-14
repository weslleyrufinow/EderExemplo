%{
#include <stdlib.h>
#include <stdio.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror (const char* s); 

%}

%union {
    int ival;
}

%token<ival> T_INT
%token T_SUM T_SUB T_MUL T_DIV T_L_PAR T_R_PAR
%token T_NEWLINE

%left T_SUM T_SUB
%left T_MUL T_DIV

%type<ival> exp

%start calc

%%

calc: 
    | calc line
;

line: T_NEWLINE                 
    | exp T_NEWLINE      {printf("Resultado: %d\n", $1);}
;

exp: T_INT               {$$ = $1;}
   | exp T_SUM exp       {$$ = $1 + $3;}
   | exp T_SUB exp       {$$ = $1 - $3;}
   | exp T_MUL exp       {$$ = $1 * $3;}
   | exp T_DIV exp       {$$ = $1 / $3;}
   | T_L_PAR exp T_R_PAR {$$ = $2;}
;

%%

int main(){
    yyin = stdin;

    do {
        yyparse();
    }while(!feof(yyin));
    
    return 0;
}

void yyerror(const char* s){
    fprintf(stderr, "%s\n", s);
    exit(1);
}
