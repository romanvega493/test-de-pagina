import wollok.game.*

/*---------------------------------------------------------//Arquetipos//---------------------------------------------------------*/

//Clase que representa un arquetipo de personaje, se encarga de definir los atributos y comportamientos del personaje.
class ArquetipoPersonaje {
    const image = ""
    const vidasIniciales = 1
    const tiempoExtra = 0
    const tiempoTrampa = 3000
    const tiempoStun = 3000

    method personajeImagen() = image
    method vidasIniciales() = vidasIniciales
    method tiempoExtra() = tiempoExtra
    method tiempoTrampa() = tiempoTrampa
    method tiempoStun() = tiempoStun


    method iniciarReloj(reloj) {
        game.schedule(self.tiempoStun(), { reloj.iniciarTemporizador() })
    }
}






