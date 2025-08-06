%{
#include "parser.tab.h"
#include <string.h>
%}

%%

int             { return INT; }
char            { return CHAR; }
","             { return COMMA; }
";"             { return SEMICOLON; }
[a-zA-Z_][a-zA-Z0-9_]*    { yylval.str = strdup(yytext); return ID; }
[ \t\n]+        ; // Ignorar espacios en blanco
.               { return yytext[0]; }

%%

int yywrap() { return 1; }
