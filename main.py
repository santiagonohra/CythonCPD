import Planeta_cy
import Planeta_py
import time

steps=1000000
time_frame = 100

planet_cy = Planeta_cy.Planet()
planet_py = Planeta_py.Planet()

init_time=time.time()
Planeta_py.step_time(planet_py, time_frame, steps)
end_time=time.time()

time_python = end_time - init_time

init_time=time.time()
Planeta_cy.step_time(planet_cy, time_frame, steps)
end_time=time.time()

time_cython = end_time - init_time

print("Tiempo de ejecucion con python: {}s\nTiempo de ejcucion con cython: {}s".format(time_python, time_cython))

print("Cython es ",time_python/time_cython, " más rápido que python")