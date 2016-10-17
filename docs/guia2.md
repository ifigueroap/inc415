# Guía Nº2 de Ejercicios Racket #

## Introducción ##


En Racket las
[listas](https://users.dcc.uchile.cl/~etanter/preplai/Estructuras_de_Datos.html#%28part._.Listas%29)
son estructuras de datos inductivas que se construyen mediante la
concatenación bien formada de pares. En resumen, una lista siempre
corresponde a uno---y sólo uno---de los siguientes casos:

- Es una lista vacía `'()`
- Es una lista no vacía `(cons h t)` donde `h` es un valor arbitrario,
la cabeza de la lista, y `t`es el resto o *cola* de la lista.


En esta segunda guía se le pide que implemente diversas funciones que
trabajan con ***listas***. En cada
pregunta se le otorga una *definición incompleta*, que usted **debe**
usar. Es decir, sólo debe cambiar la parte donde dice `...` y ahí
poner su implementación.

***Importante:*** debe utilizar solamente **llamadas recursivas** para
hacer cálculos que involucren repetición. No está permitido usar
estructuras tipo `for`. Si es necesario ***puede definir nuevas
funciones auxiliares***.

***Importante 2:*** por defecto en el lenguaje Racket los valores
son *inmutables*. Esto quiere decir que una vez asociado un valor a un
identificador, el valor ya no puede cambiar nunca. ***En esta tarea
debe usar solamente valores inmutables***.

## Evaluación ##

La guía será evaluada en dos pasos:

1. Ejecución de casos de prueba.
[Descargar plantilla que incluye casos de prueba](plantilla_guia2.rkt).

2. Cada una de las funciones que ***satisface al menos 1 de sus casos de
prueba*** será revisada manualmente para verificar:

	- que se implementó "*sin trampa*". Por ejemplo, es trampa hacer
	muchos `if`, uno para cada caso de prueba, y no realizar realmente
	el cálculo que se pide.

	- si existe una función predefinida de Racket que implementa *justo*
      lo que se le pide en la pregunta, ***no debe usarla***. Debe
      implementar utilizando recursión.

	- no obstante lo anterior, puede usar las funciones predefinidas
      si no hacen *justo* lo que se pide en la pregunta. Por ejemplo,
      puede usar `append` para implementar `my-reverse`. Pero no puede
      usar `reverse` para implementar `my-reverse`!
	
	- que sigue la [Guía de Estilo para Racket](http://docs.racket-lang.org/style/)

La guía tiene un total de 100 puntos, y cada una de las 20 preguntas
tiene un valor de 5 puntos. La puntuación será como sigue:

- Pasa *todos* los casos de prueba: 3 puntos.
	- No hace trampa y sigue guía de estilo: 2 puntos.
	
- Pasa *al menos 1* de los casos de prueba: 2 puntos.
	- No hace trampa y sigue guía de estilo: 1 punto.

La nota mínima 4.0 se obtiene con un 60% de exigencia, es decir 60
puntos. La escala completa a utilizar es
[la siguiente](http://escaladenotas.cl/?nmin=1&nmax=7.0&napr=4.0&exig=60.0&pmax=100.0&paso=1.0&orden=ascendente)

## Fecha de Entrega ##

Fecha de publicación: Martes 17 de Octubre
Fecha de entrega: **Jueves 26 de Octubre**

***Entrega por Aula Virtual***

## Enunciados ##

1. Implemente la función `my-member` que dada una lista `l` y un valor
   `v` retorna `#t` si `v` está contenido en `l`, o bien retorna `#f`
   en cualquier otro caso.

	```scheme
	(define (my-member v l) ...)
	```

	En Racket esto *se parece* a la función `member`. ***No puede
    usarla en su solución!***.
	

1. Implemente la función `my-length` que dada una lista `l`, retorna
   su largo o cantidad de elementos.

	```scheme
	(define (my-length l) ...)
	```

	En Racket esto corresponde a la función `lenght`. ***No puede
    usarla en su solución!***.
	

1. Implemente la función `my-filter` que dado un predicado `p` y una
   lista `l`, retorne una nueva lista que contiene solamente los
   elementos de `l` que cumplen con `p`---***respetando las posiciones
   relativas a `l`.***

	```scheme
	(define (my-filter p l) ...)
	```

	En Racket esto corresponde a la función `filter`. ***No puede
    usarla en su solución!***.
	

1. Implemente la función `my-list-ref` que retorna el `k`-ésimo
   elemento de una lista. Si llega al final de la lista porque `k` es
   mayor al largo de la lista, produzca un error de ejecución con la
   función predefinida `error`. Enumere los elementos desde `1` hasta
   el largo de la lista.

	```scheme
	(define (my-list-ref k l) ...)
	```

	En Racket esto corresponde a la función `list-ref`. ***No puede
    usarla en su solución!***.


1. Implemente la función `list-max` que dada una lista `l` que
   contiene sólo números, retorna el mayor elemento de `l`. Si `l` es
   una lista vacía, señale un `error`.

	```scheme
	(define (list-max l) ...)
	```
   

1. Implemente la función `list-min` que dada una lista `l` que
   contiene sólo números, retorna el menor elemento de `l`. Si `l` es
   una lista vacía, señale un `error`.

	```scheme
	(define (list-min l) ...)
	```


1. Implemente la función  `my-reverse` que dada una lista, retorna una
   nueva lista con los elementos en orden inverso.

	```scheme
	(define (my-reverse l) ...)
	```

	En Racket esto corresponde a la función `reverse`. ***No puede
    usarla en su solución!***.
	

1. Implemente la función `my-take` que dada una lista `l`  y un entero
   no-negativo `n`, retorne una lista con los primeros `n` elementos de
   `l`.

	```scheme
	(define (my-take n l) ...)
	```

	En Racket esto corresponde a la función `take`. ***No puede usarla
    en su solución!***.
	

1. Implemente la función `my-drop` que dada una lista `l` y un entero
   `n`, retorne una lista con todos los elementos de `l` ***excepto
   los `n` primeros elementos***.

	```scheme
	(define (my-drop n l) ...)
	```

	En Racket esto corresponde a la función  `drop`. ***No puede
    usarla en su solución!***.
	

1. Implemente la función `rango` que dada una lista `l` y dos enteros `a` y `b`,
   retorne una lista con los elementos de `l` entre las posiciiones
   `a` y `b`, ambas inclusive.

	```scheme
	(define (rango l a b) ...)
	```

	***Hint:*** puede usar `take` y `drop` para implementar más
    fácilmente esta función.
	

1. Implemente la función `my-append` que dadas dos listas `l1` y `l2`,
   retorne una lista con la concatenación de ambas. Es decir, una
   lista donde primero están todos los elementos de `l1` y luego todos
   los elementos de `l2`.

	```scheme
	(define (my-append l1 l2) ...)
	```

	En Racket esto corresponde a la función `append`. ***No puede
    usarla en su solución!***.
	

1. Implemente la función `list-sub` que dada una lista `l` que
   contiene sólo números, retorne la resta sucesiva de sus elementos.

	```scheme
	(define (list-sub l) ...)
	```


1. Implemente la función `list-add` que dada una lista `l` que
   contiene sólo números, retorne la suma sucesiva de sus elementos.

	```scheme
	(define (list-add l) ...)
	```


1. Implemente la función `list-mult` que dada una lista `l` que
   contiene sólo números, retorne el producto de sus elementos.

	```scheme
	(define (list-mult l) ...)
	```


1. Implemente la función `my-fold` que generaliza las operaciones de
   acumulación de valores sobre una lista. En los casos de prueba se
   usará su implementación de `my-fold` para reimplementar `list-sub`,
   `list-add` y `list-mult`.

	```scheme
	(define (my-fold f l v) ...)
	```

	En Racket esto corresponde a la función `foldl`. ***No puede
    usarla en su solución!***.


1. Implemente la función `list-square` que dada una lista `l` que
   contiene sólo números, retorne una lista con los cuadrados de cada
   elemento---***respetando el orden original en `l`***.

	```scheme
	(define (list-square l) ...)
	```


1. Implemente la función `list-halve` que dada una lista `l` que
   contiene sólo números, retorne una lista donde los valores fueron
   reducidos a la mitad---***respetando el orden original en `l`***.

	```scheme
	(define (list-halve l) ...)
	```


1. Implemente la función `my-map` que generaliza las operaciones de
   transformación de valores de una lista. En los casos de prueba se
   usará su implementación de `my-map` para reimplementar
   `list-square` y `list-halve`.

	```scheme
	(define (my-map f l) ...)
	```

	En Racket esto corresponde a la función `map`. ***No puede usarla
    en su solución!***.


1. Implemente la función `my-flatten` que dada una lista `l`, donde
   `l` puede tener otras listas como elementos, retorne una versión
   *aplanada* con todos los datos en una lista sin ninguna lista
   anidada.

	```scheme
	(define (my-flatten l) ...)
	```

	En Racket esto corresponde a la función `flatten`. ***No puede
    usarla en su solución!***.


1. Implemente la función `deep-reverse` que dada una lista `l`, donde
   `l` puede tener otras listas como elementos, retorne una versión de
  `l` donde los elementos `l` están ***recursivamente
   reversados***. 

	```scheme
	(define (deep-reverse l) ...)
	```

	Ejemplo: `(deep-reverse '(1 (2 3) (4 (5 6) 7) 8))` debe dar como
    resultado: `'(8 (7 (6 5) 4) (3 2) 1)`.


