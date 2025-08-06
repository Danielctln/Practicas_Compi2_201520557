%{
#include "parser.tab.h"
%}

%%

[01]+(\.[01]+)?    { yylval.str = strdup(yytext); return BINARIO; }
[ \t\n]+           { /* Ignorar espacios, tabulaciones y saltos de línea */ }
.                  { return yytext[0]; }

%%

int yywrap() {
    return 1;
}