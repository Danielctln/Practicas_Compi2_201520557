%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

int elemento_actual = 1; // Índice del elemento actual
%}

%token DIGITO LETRA COMA ERROR

%%

input:
    lista '\n' {
        printf("Cadena válida\n");
    }
    | lista ERROR {
        printf("Error en el elemento %d\n", elemento_actual);
        YYABORT;
    }
    ;

lista:
    DIGITO COMA letra_lista
    ;

letra_lista:
    LETRA COMA digito_lista
    ;

digito_lista:
    DIGITO COMA letra_lista
    | DIGITO
    ;

letra_lista:
    LETRA COMA digito_lista
    | LETRA
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

int main() {
    printf("Ingrese una lista separada por comas:\n");
    yyparse();
    return 0;
}

/*
flex lexer.l
bison -d parser.y
gcc parser.tab.c lex.yy.c -o analizador

./analizador
*/