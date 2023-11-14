%{
#include <stdlib.h>
#define YY_DECL int yylex()
#include "wBison.tab.h"
/*
flex -o wFlex.c wFlex.l
gcc -o wFlex.out wFlex.c -lfl

clear && flex -o wFlex.c wFlex.l && gcc -o wFlex.out wFlex.c -lfl && ./wFlex.out
*/
%}
T_NEWLINE [\n]
T_WS [ \t]
T_INT [0-9]+
T_SUM [+]
T_SUB [-]
T_MUL [*]
T_DIV [/]
T_L_PAR[(]
T_R_PAR[)]

%%

{T_WS}      {;}
{T_NEWLINE} {return T_NEWLINE;}
{T_INT}     {yylval.ival = atoi(yytext); return T_INT;}
{T_SUM}     {return T_SUM;}
{T_SUB}     {return T_SUB;}
{T_MUL}     {return T_MUL;}
{T_DIV}     {return T_DIV;}
{T_L_PAR}   {return T_L_PAR;}
{T_R_PAR}   {return T_R_PAR;}

%%
