import jugador.*

/*---------------------------------------------------------//Hud Del Juego//---------------------------------------------------------*/

//Objeto que representa el hud de vidas del juego, se encarga de mostrar la cantidad de vidas restantes del personaje.
object hudVidas{

    //Método que devuelve la ruta de la imagen del hud de vidas, se actualiza cada vez que el personaje pierde una vida delegando la responsabilidad a **personaje**.
    method image() {
        return "corazon" + personaje.vidas().toString() + ".png"
    }
    
    //Método que devuelve la posición del hud de vidas.
    method position() {
        return game.at(22, 24)
    }
}