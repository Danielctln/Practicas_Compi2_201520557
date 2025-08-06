%{
#include "parser.tab.h"  // Incluir el encabezado generado por Bison
#include "nodo.h"        // Incluir la definición de Nodo
#include <stdlib.h>
%}

%%

[0-9]+          { yylval.num = atoi(yytext); return NUM; }
[\+\-\*/]       { return yytext[0]; }
[ \t\n]+        { /* Ignorar espacios y saltos de línea */ }
.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}