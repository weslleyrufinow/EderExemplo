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
    float fval;
}

/*Constantes*/
%token<ival> T_INT
%token<fval> T_FLOAT
%token T_SUM T_SUB T_MULT T_DIV T_LPAR T_RPAR
%token T_NEWLINE T_EXIT

%left T_SUM T_SUB
%left T_MULT T_DIV

%type<ival> exp
%type<fval> exp_f

/*Símbolo Inicial */
%start calc

%%

calc: 
    | calc line
;

line: T_NEWLINE                 
    |exp_f T_NEWLINE            {printf("\tResultado: %f\n", $1);}
    |exp T_NEWLINE              {printf("\tResultado: %d\n", $1);}
    | T_EXIT T_NEWLINE          {printf("\tTchau!!\n"); exit(0);}
;

exp_f: T_FLOAT                  {$$ = $1;}
    | exp_f T_SUM exp_f         {$$ = $1 + $3;} 
    | exp_f T_SUB exp_f         {$$ = $1 - $3;}
    | exp_f T_MULT exp_f        {$$ = $1 * $3;}
    | exp_f T_DIV exp_f         {$$ = $1 / $3;}
    | T_LPAR exp_f T_RPAR       {$$ = $2;}
    | exp T_SUM exp_f           {$$ = $1 + $3;}
    | exp T_SUB exp_f           {$$ = $1 - $3;}
    | exp T_MULT exp_f          {$$ = $1 * $3;}
    | exp T_DIV exp_f           {$$ = $1 / $3;}
    | exp_f T_SUM exp           {$$ = $1 + $3;}
    | exp_f T_SUB exp           {$$ = $1 - $3;}
    | exp_f T_MULT exp          {$$ = $1 * $3;}
    | exp_f T_DIV exp           {$$ = $1 / $3;}
    | exp T_DIV exp             {$$ = $1 / (float)$3;}
;

exp: T_INT                      {$$ = $1;}
    | exp T_SUM exp             {$$ = $1 + $3;}
    | exp T_SUB exp             {$$ = $1 - $3;}
    | exp T_MULT exp            {$$ = $1 * $3;}
    | T_LPAR exp T_RPAR         {$$ = $2;}
;

%%

//O yyparse() retorna 0  = sucesso e difrente de 0 é falha
int main(){
    yyin = stdin;

    do {
        yyparse();
    }while(!feof(yyin));
    
    return 0;
}

void yyerror(const char* s){
    fprintf(stderr, "Erro Sintático: %s \n", s);
    exit(1);
}
