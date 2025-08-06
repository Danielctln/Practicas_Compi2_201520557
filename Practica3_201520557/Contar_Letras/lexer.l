%{
#include "parser.tab.h"
%}

%%

[a-z]+    { yylval.str = strdup(yytext); return STRING; }
[ \t\n]+  { /* ignorar espacios y saltos de línea */ }
.         { /* ignorar cualquier otro carácter */ }

%%
