import jugador.*
import tiempo.*
import wollok.game.*

/*---------------------------------------------------------//Pociones Del Juego//---------------------------------------------------------*/

//Clase que representa una pocion de vida, al momento de instanciar hay que indicar la ruta de la imagen.
class PocionVida {
    var property image
    var property position

    //Método que se ejecuta al colisionar con el personaje, suma vida y elimina la poción del juego, es polimórfico.
    method colision() {
            game.say(personaje,"¡Una poción de vida!")
            personaje.sumarVida()
            game.removeVisual(self)
        }
}

//Clase que representa una pocion de tiempo heredando de PocionVida, al momento de instanciar hay que indicar la ruta de la imagen.
class PocionTiempo inherits PocionVida {

    //Método que se ejecuta al colisionar con el personaje, suma tiempo y elimina la poción del juego, es polimórfico.
    override method colision() {
            game.say(personaje,"¡Una poción de tiempo! +5 segundos")
            relojDePartida.sumarTiempo()
            game.removeVisual(self)
        }
}