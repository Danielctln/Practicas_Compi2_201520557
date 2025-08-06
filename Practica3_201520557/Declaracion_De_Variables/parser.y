%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Pair {
    char* id;
    char* type;
} Pair;

Pair pairs[100];
int pair_count = 0;

void add_pair(char* id, char* type) {
    pairs[pair_count].id = strdup(id);
    pairs[pair_count].type = strdup(type);
    pair_count++;
}

void print_pairs() {
    printf("[");
    for (int i = 0; i < pair_count; i++) {
        printf("(%s,%s)", pairs[i].id, pairs[i].type);
        if (i < pair_count - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

int yylex();
void yyerror(const char* s);
%}

%union {
    char* str;
}

%token <str> ID
%token INT CHAR
%token COMMA SEMICOLON

%type <str> type
%type <str> id_list

%%

program:
    declarations { print_pairs(); }
    ;

declarations:
    declarations declaration
    | declaration
    ;

declaration:
    type id_list SEMICOLON
    ;

type:
    INT { $$ = "int"; }
    | CHAR { $$ = "char"; }
    ;

id_list:
    ID { add_pair($1, $<str>0); $$ = $<str>0; }
    | id_list COMMA ID { add_pair($3, $<str>1); $$ = $<str>1; }
    ;

%%

int main() {
    printf("Ingrese las declaraciones de variables Al finalizar la entrada presionar Ctrl+D\n");
    yyparse();
    return 0;
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s\n", s);
}

/*
flex lexer.l
bison -d parser.y
gcc lex.yy.c parser.tab.c -o parser
./parser

*/
