import wollok.game.*
import pantallas.*

/*---------------------------------------------------------//Cinematica Del Juego//---------------------------------------------------------*/

//Objeto que representa la cinemática del juego, se encarga de mostrar las imágenes del inicio y avanzar a la siguiente imagen al presionar la tecla F.
object cinematica {
    const imagenes = ["cinematica1.png", "cinematica2.png", "cinematica3.png", "cinematica4.png"]
    var indiceActual = 0
    
    var property position = game.at(0, 0)

    //Método que devuelve la ruta de la imagen actual de la cinemática.
    method image() = imagenes.get(indiceActual)

    //Método que inicia la cinemática, agregandose al juego y asignando la acción de avanzar a la siguiente imagen al presionar la tecla F.
    method iniciar() {
        indiceActual = 0
        game.addVisual(self)
        keyboard.f().onPressDo({ self.avanzar() })
    }

    //Método que avanza a la siguiente imagen de la cinemática, si es la última imagen finaliza la cinemática.
    method avanzar() {
        indiceActual = indiceActual + 1
        if (self.esElFinal()) {
            self.finalizar()
        }
    }

    //Método que devuelve true si la cinemática llegó a su fin, false en caso contrario.
    method esElFinal() = indiceActual >= imagenes.size()

    //Método que finaliza la cinemática, eliminandose y mostrando el menú de inicio.
    method finalizar() {
        game.removeVisual(self)
        inicio.mostrarMenu()
    }
}