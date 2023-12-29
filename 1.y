%token INTEGER
%right '='
%left '+' '-'
%left '*' '/'

%{
#include <stdio.h>
int yylex(void);
void yyerror (char*);
extern FILE * yyin;
extern FILE * yyout;
FILE * yyError;
	

%}


%%

program:
        program statement '\n'
        | 
        ;

statement:
        expr                      { fprintf(yyout,"%d\r", $1); }
        |
        ;

expr:
	INTEGER 		{ $$ = $1; }
	| expr '*' expr           { $$ = $1 * $3; }
        | expr '/' expr           { $$ = $1 / $3; }
        | expr '+' expr           { $$ = $1 + $3; }
        | expr '-' expr           { $$ = $1 - $3; }
        | '(' expr ')'            { $$ = $2; }
        ;
%%
void yyerror (char *s)
{
fprintf(yyError, "%s\r\n", s);
}

int main (void)
{
yyin = fopen("input.txt", "r");
yyout = fopen("output.txt", "w");
yyError = fopen("outError.txt", "w");
yyparse();
fclose(yyin);
fclose(yyout);
return 0;
}