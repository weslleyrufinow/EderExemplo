%{
#include <stdio.h>
#include <stdlib.h>
%}

%token T_INT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE
%token T_LPAREN T_RPAREN
%token T_NEWLINE

%left '+' '-'
%left '*' '/'

%start calc

%union {
    char* sval;
}

%type<sval> exp

%%

calc: 
    | calc line
;

line: T_NEWLINE
    | exp { printf("%s\n", $1); free($1); }
;

exp: T_INT { $$ = strdup(yytext); }
    | exp '+' exp { $$ = asprintf("%s %s +", $1, $3); free($1); free($3); }
    | exp '-' exp { $$ = asprintf("%s %s -", $1, $3); free($1); free($3); }
    | exp '*' exp { $$ = asprintf("%s %s *", $1, $3); free($1); free($3); }
    | exp '/' exp { $$ = asprintf("%s %s /", $1, $3); free($1); free($3); }
    | '(' exp ')' { $$ = $2; }
;

%%

int main(){
    yyparse();
    return 0;
}

void yyerror(const char* s){
    fprintf(stderr, "%s\n", s);
    exit(1);
}
