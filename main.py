'''
Fecha: 1 nov 2022
Autor: Santiago Nohra
Tema: Cython
La idea es exportar un .csv con la toma de datos
'''

import Planeta_cy
import Planeta_py
import time


#Se inicializa planeta para python, datos de wikipedia (Tierra)
planet_py = Planeta_py.Planet()
planet_py.x = 100*10**3
planet_py.y = 300*10**3
planet_py.z = 700*10**3

planet_py.vx = 2.00*10**3
planet_py.vy = 29.87*10**3
planet_py.vz = 0.034*10**3

planet_py.m = 5.97424*10**24

#Se inicializa planeta para python, datos de wikipedia (Tierra)
planet_cy = Planeta_cy.Planet()
planet_cy.x = 100*10**3
planet_cy.y = 300*10**3
planet_cy.z = 700*10**3

planet_cy.vx = 2.00*10**3
planet_cy.vy = 29.87*10**3
planet_cy.vz = 0.034*10**3

planet_cy.m = 5.97424*10**24

#Se consideran las otras variables
steps = 2000000
time_span = 400

#Formato para el fichero de salida
formato_datos = "{:.5f},{:.5f}\n"


#Definicion de experimentos, reduccion de ruido gaussiano
for i in range(5):

    #Toma de tiempos para python
    init_time=time.time()
    Planeta_py.step_time(planet_py, time_span, steps)
    end_time=time.time()

    time_python = end_time - init_time

    #Toma de tiempos para cython
    init_time=time.time()
    Planeta_cy.step_time(planet_cy, time_span, steps)
    end_time=time.time()

    time_cython = end_time - init_time

    with open("planeta.csv", "a") as archivo:
        archivo.write(formato_datos.format(time_python, time_cython))





print("Tiempo de ejecucion con python: {}s\nTiempo de ejcucion con cython: {}s".format(time_python, time_cython))

print("Cython es ",time_python/time_cython, " más rápido que python")