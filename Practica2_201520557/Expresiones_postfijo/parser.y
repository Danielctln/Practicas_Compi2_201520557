%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "nodo.h"  // Incluir la definición de Nodo

Nodo stack[MAX];
int top = -1;

void push(Nodo n) {
    if (top >= MAX - 1) {
        fprintf(stderr, "Error: Pila desbordada\n");
        exit(1);
    }
    stack[++top] = n;
}

Nodo pop() {
    if (top < 0) {
        fprintf(stderr, "Error: Pila vacía\n");
        exit(1);
    }
    return stack[top--];
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

int yylex();
%}

%union {
    int num;
    Nodo nodo;
}

%token <num> NUM
%type <nodo> expr

%%

input:
    /* vacío */
    | input expr '\n' {
        printf("= %s\n", $2.expr);
    }
    ;

expr:
    NUM {
        Nodo n;
        snprintf(n.expr, MAX, "%d", $1);
        push(n);
    }
    | expr expr '+' {
        Nodo b = pop();
        Nodo a = pop();
        Nodo n;
        snprintf(n.expr, MAX, "(%s + %s)", a.expr, b.expr);
        push(n);
    }
    ;

%%
int main() {
    printf("Ingrese una expresión en notación postfija:\n");
    yyparse();
    return 0;
}