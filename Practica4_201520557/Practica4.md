## 1. Declaración de variables
Declaración de variables Dado una entrada de declaraciones de variables con su tipo, propagar el tipo correspondiente a cada identificador usando atributos heredados, al final de la evaluación, una lista de pares (ID, Type) que representa todas las declaraciones del bloque. Ejemplo de entrada: int x, y; char a; int b; Salida esperada: [(x,int), (y,int), (a,char), (b,int)]

### Gramática
```ebnf
D   → L ; D
    | L ;
L   → T V
T   → int
    | char
V   → V , id
    | id
```

## 2. Formateo de bloques
Formateo de bloques con identación Dado un programa compuesto por secuencias de sentencias print e instrucciones condicionales if … then … else …, formatear la salida añadiendo espacios al inicio de cada línea según el nivel de anidación. El nivel de indentación se crece en 1 unidad cada vez que se entra al “then” o al “else”. Ejemplo de entrada: print(a); if(a>0) then print(b); else print(c); Salida esperada: print(a); if(a>0) then print(b); else print(c);

### Gramática
```ebnf
P   → S P
    | S
S   → print ( E ) ;
    | if ( E ) then S else S
```
