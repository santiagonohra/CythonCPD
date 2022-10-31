from math import sqrt

cdef class Planet(object):

    cdef public double x, y, z, vx, vy, vz, m

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

cdef void single_step(planet, dt):
    '''Dar un paso'''

    #Calcular fuerza: gravedad al origen
    cdef double distance = sqrt(planet.x**2 + planet.y**2 + planet.z**2)
    cdef double Fx = -planet.x / distance**3
    cdef double Fy = -planet.y / distance**3
    cdef double Fz = -planet.z / distance**3

    #Posicion a partir de la velocidad y el tiempo
    planet.x += dt * planet.vx
    planet.y += dt * planet.vy
    planet.z += dt * planet.vz

    #Velocidad a partir de fuerza y masa
    planet.vx += dt * Fx / planet.m
    planet.vy += dt * Fy / planet.m
    planet.vz += dt * Fz / planet.m
 
def step_time(planet, time_span, n_steps):
    '''Dar n cantidad de pasos'''
    cdef double dt = time_span / n_steps
    cdef int j
    for j in range(n_steps):
        single_step(planet, dt)

