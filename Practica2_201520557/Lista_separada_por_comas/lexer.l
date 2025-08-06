%{
#include "parser.tab.h"
%}

DIGITO      [0-9]
LETRA       [A-Za-z]
COMA        ,

%%

{DIGITO}    { return DIGITO; }
{LETRA}     { return LETRA; }
{COMA}      { return COMA; }
\n          { return '\n'; }
.           { return ERROR; }

%%

int yywrap() {
    return 1;
}