%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void yyerror(const char *s);
int yylex();

double convertir_binario_a_decimal(const char *binario);
%}

%union {
    char *str;
    double num;
}

%token <str> BINARIO
%type <num> expr

%%

input:
    expr { printf("= %lf\n", $1); }
    ;

expr:
    BINARIO { $$ = convertir_binario_a_decimal($1); free($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

double convertir_binario_a_decimal(const char *binario) {
    const char *punto = strchr(binario, '.');
    double resultado = 0.0;

    if (punto) {
        // Parte entera
        for (const char *ptr = binario; ptr < punto; ++ptr) {
            resultado = resultado * 2 + (*ptr - '0');
        }

        // Parte fraccionaria
        double factor = 0.5;
        for (const char *ptr = punto + 1; *ptr != '\0'; ++ptr) {
            resultado += (*ptr - '0') * factor;
            factor /= 2;
        }
    } else {
        // Solo parte entera
        for (const char *ptr = binario; *ptr != '\0'; ++ptr) {
            resultado = resultado * 2 + (*ptr - '0');
        }
    }

    return resultado;
}

int main() {
    printf("Ingrese un número binario:\n");
    return yyparse();
}

/*
flex lexer.l
bison -d parser.y
gcc lex.yy.c parser.tab.c -o analizador -lm

./analizador
*/