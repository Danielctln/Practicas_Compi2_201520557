%{
#include "parser.tab.h"
#include <string.h>
%}

%%
">"     { return GT; }
"<"     { return LT; }
"=="    { return EQ; }
"!="    { return NEQ; }
"="     { return ASSIGN; }
[0-9]+  { yylval.str = strdup(yytext); return NUMBER; }
print           { return PRINT; }
if              { return IF; }
then            { return THEN; }
else            { return ELSE; }
";"             { return SEMICOLON; }
"("             { return '('; }
")"             { return ')'; }
[ \t\n]+        ; // Ignorar espacios en blanco
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }
.               { return yytext[0]; }

%%

int yywrap() { return 1; }
