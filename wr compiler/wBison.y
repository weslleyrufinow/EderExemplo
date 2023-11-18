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
    char* sval;
}

%token<ival> T_INT
%token T_SUM T_SUB T_MUL T_DIV T_L_PAR T_R_PAR
%token T_NEWLINE

%left T_SUM T_SUB
%left T_MUL T_DIV

%type<sval> exp

%start calc

%%

calc: 
    | calc line
;

line: T_NEWLINE                 
    | exp T_NEWLINE      {printf("Notação posfixa: %s\n", $1); free($1);}
;

exp: T_INT               {asprintf(&$$, "%d", $1);}
   | exp T_SUM exp       {asprintf(&$$, "%s %s +", $1, $3); free($1); free($3);}
   | exp T_SUB exp       {asprintf(&$$, "%s %s -", $1, $3); free($1); free($3);}
   | exp T_MUL exp       {asprintf(&$$, "%s %s *", $1, $3); free($1); free($3);}
   | exp T_DIV exp       {asprintf(&$$, "%s %s /", $1, $3); free($1); free($3);}
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
