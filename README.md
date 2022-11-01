# CythonCPD
Programa de órbita de planeta en cython y python con fines de medición de rendimiento.

# Descripción
Este repositorio cuenta con los ficheros de simulación de la órbita de un planeta, con su posicion y velocidad en 3 dimensiones y su masa. Se realizó un módulo en Python y otro Cython con el fin de comparar el rendimiento del lenguaje interpretado vs el compilado respectivamente.

# Uso
Clonar el repositorio

`git clone https://github.com/santiagonohra/CythonCPD.git`

`cd CythonCPD`

Compilar el módulo de Cython

`python3 setup.py build_ext --inplace`

Con esto anterior se obtiene un fichero `.so`, el cual permite importar el modulo escrito en Cython a un programa de Python tradicional, tal como una biblioteca.

Para usar el módulo, es necesario importarlo, para hacerlo en Python, se hace uso de lo siguiente en el archivo `.py` que quiera importar este módulo.

`import Planeta_cy`

*Nota, esto es en el archivo `.py`

Con esto ya se tiene acceso el módulo, y por extensión a sus clases y métodos.

Para ejecutar la prueba incluida, simplemente se ejecuta:

`python3 main.py`

En este fichero `main.py` se hace una prueba del modulo `Planeta_py.py` y `Planeta_cy.pyx` con `1,000,000` de steps y en un time_frame de `100`. Como salida se muestra en la terminal el tiempo de ejecución con Cython, con Python, y la relación entre estos.


