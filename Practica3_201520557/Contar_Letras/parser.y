%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    char* str;
    int count;
}

%token <str> STRING
%type <count> input

%%

input:
    STRING {
        int total = 0;
        char* s = $1;
        for (int i = 0; s[i] != '\0'; i++) {
            if (s[i] == 'a') total++;
        }
        printf("%d\n", total);
        free(s);
    }
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
  printf("Ingrese las declaraciones de variables Al finalizar la entrada presionar Ctrl+D\n");
  printf("\n");
    return yyparse();
}

/*
bison -d parser.y
flex lexer.l
gcc parser.tab.c lex.yy.c -o parser -lfl
./parser
*/
