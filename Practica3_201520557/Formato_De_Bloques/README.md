# Bison Indentation Project

Este proyecto implementa un analizador léxico y sintáctico utilizando Flex (lexer) y Bison (parser) para un lenguaje simple que incluye sentencias `print` e instrucciones condicionales `if ... then ... else ...`. El objetivo principal es formatear bloques de código con la indentación adecuada según el nivel de anidación.

## Estructura del Proyecto

```
bison-indentation-project
├── src
│   ├── lexer.l          # Analizador léxico que define los tokens del lenguaje.
│   ├── parser.y         # Analizador sintáctico que maneja la gramática y la indentación.
│   ├── main.c           # Punto de entrada del programa.
│   └── utils
│       └── indentation.c # Funciones auxiliares para manejar la indentación.
├── Makefile             # Instrucciones para compilar el proyecto.
└── README.md            # Documentación del proyecto.
```

## Instrucciones de Compilación

Para compilar el proyecto, asegúrate de tener instalado Flex y Bison. Luego, ejecuta el siguiente comando en la terminal desde la raíz del proyecto:

```
make
```

Esto generará el ejecutable del programa.

## Ejecución del Programa

Una vez compilado, puedes ejecutar el programa con el siguiente comando:

```
./bison-indentation-project
```

Asegúrate de proporcionar un archivo de entrada que contenga el código que deseas formatear.

## Ejemplo de Uso

Dado un archivo de entrada `input.txt` con el siguiente contenido:

```
print "Hello, World!";
if condition then
print "Condition is true";
else
print "Condition is false";
```

La salida formateada será:

```
print "Hello, World!";
if condition then
    print "Condition is true";
else
    print "Condition is false";
```

## Descripción de la Funcionalidad

- **lexer.l**: Define las reglas para identificar los tokens del lenguaje, incluyendo `print`, `if`, `then`, `else`, y delimitadores como `;`.
- **parser.y**: Maneja la gramática del lenguaje y ajusta la indentación de acuerdo con el nivel de anidación.
- **main.c**: Inicializa el analizador y gestiona la ejecución del programa.
- **indentation.c**: Contiene funciones para manejar la lógica de indentación.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas mejorar el proyecto, por favor abre un issue o envía un pull request.