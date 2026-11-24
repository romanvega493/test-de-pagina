import wollok.game.*
import pantallas.*
import jugador.*
import mapa.*

/*---------------------------------------------------------//Salida Del Juego//---------------------------------------------------------*/

//Objeto que representa la salida del juego.
object salida {
  method position() = game.at(29, 23)
  method image() = "objetoSalida.png"

  //Método que se ejecuta al colisionar con el personaje, llama al método **alLlegarASalida** del nivel actual delegando responsabilidades.
  method colision() {
      inicio.nivelActual().alLlegarASalida()
    }
  }