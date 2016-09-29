# INC 415 - Lenguajes de Programación
## Guía Nº1 de Ejercicios Racket

### Introducción

En Racket las funciones se definen utilizando la directiva `define`.
Una función tiene un nombre, un listado de parámetros y un *cuerpo*.
Por ejemplo:

```scheme
(define (double x)
	(+ x x))
```

Define la función `double` que duplica el valor de su argumento. Otro
ejemplo de una función que toma más de un argumento es:

```scheme
(define (maximo a b)
	(if (> a b)
		a
		b))
```

En esta primera guía se le pide que implemente diversas funciones que
trabajan principalmente con números. En cada pregunta se le otorga
una *definición incompleta*, que usted **debe** usar. Es decir, sólo
debe cambiar la parte donde dice `...` y ahí poner su implementación.

***Importante:*** debe utilizar solamente **llamadas recursivas** para
hacer cálculos que involucren repetición. No está permitido usar
estructuras tipo `for`. Si es necesario ***puede definir nuevas
funciones auxiliares***.

***Importante 2:*** por defecto en el lenguaje Racket los valores
son *inmutables*. Esto quiere decir que una vez asociado un valor a un
identificador, el valor ya no puede cambiar nunca. ***En esta tarea
debe usar solamente valores inmutables***.

### Evaluación

La guía será evaluada en dos pasos:

1. Ejecución de casos de prueba.
[Descargar casos de prueba](pruebas_guia1.rkt).

2. Cada una de las funciones que ***satisface al menos 1 de sus casos de
prueba*** será revisada manualmente para verificar:

	- que se implementó "*sin trampa*". Por ejemplo, es trampa hacer
	muchos `if`, uno para cada caso de prueba, y no realizar realmente
	el cálculo que se pide.
	
	- que sigue la [Guía de Estilo para Racket](http://docs.racket-lang.org/style/)

La guía tiene un total de 100 puntos, y cada una de las 20 preguntas
tiene un valor de 5 puntos. La puntuación será como sigue:

- Pasa *todos* los casos de prueba: 3 puntos.
	- No hace trampa y sigue guía de estilo: 2 puntos.
	
- Pasa *al menos 1* de los casos de prueba: 2 puntos.
	- No hace trampa y sigue guía de estilo: 1 punto.

La nota mínima 4.0 se obtiene con un 60% de exigencia, es decir 60
puntos. La escala completa a utilizar es [la siguiente](http://escaladenotas.cl/?nmin=1&nmax=7.0&napr=4.0&exig=60.0&pmax=100.0&paso=1.0&orden=ascendente)

### Fecha de Entrega

Fecha de publicación: Jueves 29/09/2016
Fecha de entrega: **Viernes 07/10/2016**

***Entrega por Aula Virtual***

### Enunciados

1.  Implemente la función `tres-cuadrados`. Esta función toma tres
números como argumento y retorna la suma de los cuadrados de los dos
números mayores.

	```scheme
	(define (tres-cuadrados a b c) ...)
	```

1.  Implemente la función `factorial`que calcula el factorial de un
entero no-negativo `n`.

	```scheme
	(define (factorial n) ...)
	```

1. Implemente la función `fibs` que calcula el `k`-ésimo número de
Fibonacci.

	```scheme
	(define (fibs k) ...)
	```

1. Implemente la función `potencia` que recibe dos números enteros:
`base` y `exponente`, y calcula la potencia de elevar la base al
exponente. Asuma que el exponente es siempre un entero no-negativo.

	```scheme
	(define (potencia base exponente) ...
	```

1. Implemente la función `primo?`que retorna verdadero `#t` o falso
`#f` según si el argumento que recibe es o no un número primo.

	```scheme
	(define (primo? n) ...)
	```

1. Implemente la función `a-suma-abs-b` que suma el valor de `a` con
el valor absoluto de `b`.

	```scheme
	(define (a-suma-abs-b a b) ...)
	```

1. Implemente la función `suma-digitos` que suma el valor de los
dígitos de un número `n`dado.

	```scheme
	(define (suma-digitos n) ...)
	```

1. Implemente la función `numero-central` que dados tres números `a`,
`b` y `c`, retorna el que esta al centro, según el orden de los
números.

	```scheme
	(define (numero-central a b c) ...)
	```

1. Un número es *alternante* si su primer dígito es par (impar) y
luego el siguiente dígito es impar (par), y así sucesivamente. Esto
requiere una cantidad par de dígitos. Implemente la función
`alternante?` que retorna `#t` o `#f` según si el número `n`dado es o
no alternante.

	```scheme
	(define (alternante? n) ...)
	```

1. Un número es *perfecto* si la suma de sus *divisores propios*, es
decir aquellos que no son ni 1 ni el mismo número, es igual al número.
Implemente la función `perfecto?` que retorna `#t` o `#f` según si el
número `n` dado es o no perfecto.

	```scheme
	(define (perfecto? n) ...)
	```

1. Un número es *agradable* si la cantidad de divisores pares es igual
a la cantidad de divisores impares. Implemente la función `agradable?`
que retorna `#t` o `#f` según si el número `n` dado es o no agradable.

	```scheme
	(define (agradable? n) ...)
	```
	
1. Implemente la función `suma-cuadrados` que calcula la suma del
cuadrado de los primeros `k` números naturales.

	```scheme
	(define (suma-cuadrados k) ...)
	```

1. Implemente la función `suma-cos` que calcula la suma del coseno de
los primeros `k`números naturales.

	```scheme
	(define (suma-cos k) ...)
	```

1. Implemente la función `suma-abstracta` que, dada una función `f`
que recibe como argumento, calcula la suma de las aplicaciones de `f`
a cada uno de los primeros `k` elementos.

	```scheme
	(define (suma-abstracta f k) ...)
	```

1. Utilizando `suma-abstracta`, implemente la función
`suma-cuadrados-abs` que hace lo mismo que `suma-cuadrados`.

	```scheme
	(define (suma-cuadrados-abs k)
		(suma-abstracta ...))
	```
1. Utilizando `suma-abstracta`, implemente la función
`suma-cos-abs`que hace lo mismo que `suma-cuadrados`.

	```scheme
	(define (suma-cos-abs k)
		(suma-abstracta ...))
	```

1. Implemente la función `suma-abstracta-rango` que hace lo mismo que
`suma-abstracta` pero sobre el rango de enteros entre un `i` y un `j`,
ambos inclusive, dados como parámetros.

	```scheme
	(define (suma-abstracta rango f i j) ...)
	```

1. Utilizando `suma-abstracta-rango` implemente la función
`suma-cuadrados-rango`que hace lo mismo que `suma-cuadrados` pero en
el rango de enteros entre `i` y `j`, **pero sin incluir `i`**.

	```scheme
	(define (suma-cuadrados-rango i j)
		(suma-abstracta-rango ...))
	```

1. Utilizando `suma-abstracta-rango` implemente la función
`suma-cos-rango` que hace lo mismo que `suma-cos` pero en el rango de
enteros entre `i` y `j`, **pero sin incluir `j`**.

	```scheme
	(define (suma-cos-rango i j)
		(suma-abstracta ...))
	```

1. Implemente la función `suma-abstracta-rango-paso` que recibe los
enteros `i` y `j`, pero donde el incremento no se hace 1 a 1 si no que
se hace según un parámetro `p`.

	```scheme
	(define (suma-abstracta-rango-paso f i j p) ...)
	```
