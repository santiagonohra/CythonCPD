#cython: language_level=3
cimport cython

'''
Fecha: 1 nov 2022
Autor: Santiago Nohra
Tema: Cython
'''

'''
Se requiere la raiz cuadrada:
    Se instancia como funcion externa
    y se prepara para multihilo. nogil = Bloqueo global
'''
cdef extern from "math.h":
    double sqrt(double x) nogil

cdef class Planet(object):
    #Declaracion de variables publicas
    cdef public float x, y, z, vx, vy, vz, m

    def __init__(self):
        #Posicion y velocidad (3D)
        self.x = 1.0
        self.y = 0.0
        self.z = 0.0
        self.vx = 0.0
        self.vy = 0.5
        self.vz = 0.0

        #Masa
        self.m = 1.0



'''
La distancia no puede ser 0
Para esto se hace una alerta basada en cython: cdivision(True/False)
Al poner true, invalida la instruccion al saltar la bandera (INF)
Se prepara con un decorador de cython
'''
@cython.cdivision(True)
cdef void single_step(Planet planet, double dt) nogil:
    '''Dar un paso'''

    #Se declaran las variables usadas
    cdef double distance, Fx, Fy, Fz 

    #Calcular fuerza: gravedad al origen
    distance = sqrt(planet.x**2 + planet.y**2 + planet.z**2)
    Fx = -planet.x / distance**3
    Fy = -planet.y / distance**3
    Fz = -planet.z / distance**3

    #Posicion a partir de la velocidad y el tiempo
    planet.x += dt * planet.vx
    planet.y += dt * planet.vy
    planet.z += dt * planet.vz

    #Velocidad a partir de fuerza y masa
    planet.vx += dt * Fx / planet.m
    planet.vy += dt * Fy / planet.m
    planet.vz += dt * Fz / planet.m
 
def step_time(Planet planet, double time_span, int n_steps):
    '''Dar n cantidad de pasos'''
    cdef double dt
    cdef int j

    dt = time_span / n_steps

    '''
    Se prepara para el paralelismo
    '''
    with nogil:
        for j in range(n_steps):
            single_step(planet, dt)

