# Guía Nº3: Análisis Léxico en Racket

## Introducción ##

Lexers


## Evaluación ##

La guía será evaluada en dos pasos:

1. Ejecución de casos de prueba.
[Descargar plantilla que incluye casos de prueba](plantilla_guia3.rkt).

2. Cada una de las funciones que ***satisface al menos 1 de sus casos de
prueba*** será revisada manualmente para verificar:

	- que se implementó "*sin trampa*". Por ejemplo, es trampa hacer
	muchos `if`, uno para cada caso de prueba, y no realizar realmente
	el cálculo que se pide.
	
	- que sigue la
    [Guía de Estilo para Racket](http://docs.racket-lang.org/style/)

**Ahora puede usar todas las funciones predefinidas de Racket que
      quiera***. Sin embargo no puede usar valores mutables!

La guía tiene un total de 100 puntos, y cada una de las 5 preguntas
tiene un valor de 20 puntos. La puntuación será como sigue:

- Pasa *todos* los casos de prueba: 15 puntos.
	- No hace trampa y sigue guía de estilo: 5 puntos.
	
- Pasa *al menos 1* de los casos de prueba: 8 puntos.
	- No hace trampa y sigue guía de estilo: 2 punto.

La nota mínima 4.0 se obtiene con un 60% de exigencia, es decir 60
puntos. La escala completa a utilizar es
[la siguiente](http://escaladenotas.cl/?nmin=1&nmax=7.0&napr=4.0&exig=60.0&pmax=100.0&paso=1.0&orden=ascendente)

## Fechas Importantes ##

- Fecha de publicación: 26 de Octubre de 2016
- Fecha de entrega: **11 de Noviembre de 2016**

***Entrega por Aula Virtual***

## Enunciados ##

Implemente un lexer en Racket para cada uno de los siguientes
casos. Cada lexer debe ignorar los espacios en blanco y los saltos de
línea, pudiendo así consumir un flujo de entrada con más de un lexema
reconocible por el lexer.

1. Identificadores válidos en C: comienzan con una letra, y pueden
contener digitos, underscore, y caracteres ASCII.

	```scheme
	(define-lexer lex-c-identifiers ...)
	```

1. Números enteros en base decimal, que puedan ser positivos o
negativos. Los negativos son precedidos por un símbolo `-`.

	```scheme
	(define-lexer lex-integers...)
	```

1. Números enteros en formato octal, que pueden ser positivos o
   negativos. Por ejemplo: `0x0`, `0x12740`.

	```scheme
	(define-lexer lex-octal-integers ...)
	```

1. Números reales (positivos y negativos) escritos en formato decimal,
por ejemplo: `-0.0000345` o bien en notación científica, por ejemplo:
`-3.45E-5`.

	```scheme
	(define-lexer lex-real-numbers ...)
	```

1. Cadenas sobre el alfabeto ASCII que comienzan con una letra
mayúscula, y que todas las otras letras son minúsculas. Las palabras
deben tener al menos 2 letras.

	```scheme
	(define-lexer lex-ascii-capital-strings ...)
	```
