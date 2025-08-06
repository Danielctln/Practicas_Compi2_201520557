%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

char* indent(const char* text) {
    char *buf = malloc(strlen(text) * 2 + 1);
    buf[0] = '\0';
    const char *p = text;
    while (*p) {
        strcat(buf, "    ");
        while (*p && *p != '\n') {
            strncat(buf, p, 1);
            p++;
        }
        if (*p == '\n') {
            strncat(buf, p, 1);
            p++;
        }
    }
    return buf;
}
%}

%union {
    char* str;
}

%token <str> ID
%token <str> NUMBER
%token GT LT EQ NEQ ASSIGN
%token PRINT IF THEN ELSE
%token SEMICOLON

%type <str> program statements statement if_statement print_statement expression

%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

program:
    statements {
        printf("%s", $1);
    }
    ;

statements:
    statements statement {
        size_t len = strlen($1) + strlen($2) + 1;
        char *buf = malloc(len + 1);
        sprintf(buf, "%s%s", $1, $2);
        $$ = buf;
    }
    | statement {
        $$ = $1;
    }
    ;

statement:
    print_statement SEMICOLON {
        size_t len = strlen($1) + 2;
        char *buf = malloc(len);
        sprintf(buf, "%s\n", $1);
        $$ = buf;
    }
    | if_statement {
        $$ = $1;
    }
    ;

print_statement:
    PRINT '(' expression ')' {
        char *buf = malloc(100 + strlen($3));
        sprintf(buf, "print(%s);", $3);
        $$ = buf;
    }
    ;

if_statement:
    IF expression THEN statements %prec LOWER_THAN_ELSE {
        char *buf = malloc(100 + strlen($2) + strlen($4));
        sprintf(buf, "if(%s) then\n%s", $2, indent($4));
        $$ = buf;
    }
    | IF expression THEN statements ELSE statements {
        char *buf = malloc(100 + strlen($2) + strlen($4) + strlen($6));
        sprintf(buf, "if(%s) then\n%selse\n%s", $2, indent($4), indent($6));
        $$ = buf;
    }
    ;

expression:
      ID                         { $$ = $1; }
    | NUMBER                     { $$ = $1; }
    | '(' expression ')'         { $$ = $2; }
    | ID GT NUMBER               {
                                    char *buf = malloc(100);
                                    sprintf(buf, "%s > %s", $1, $3);
                                    $$ = buf;
                                }
    | ID LT NUMBER               {
                                    char *buf = malloc(100);
                                    sprintf(buf, "%s < %s", $1, $3);
                                    $$ = buf;
                                }
    | ID EQ NUMBER               {
                                    char *buf = malloc(100);
                                    sprintf(buf, "%s == %s", $1, $3);
                                    $$ = buf;
                                }
    | ID NEQ NUMBER              {
                                    char *buf = malloc(100);
                                    sprintf(buf, "%s != %s", $1, $3);
                                    $$ = buf;
                                }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Ingrese las declaraciones de variables Al finalizar la entrada presionar Ctrl+D\n");
    yyparse();
    return 0;
}
/*
bison -d parser.y
flex lexer.l
gcc parser.tab.c lex.yy.c -o parser -lfl
./parser
*/