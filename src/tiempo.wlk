import wollok.game.*
import pantallas.*
import jugador.*

/*---------------------------------------------------------//Tiempo Del Juego//---------------------------------------------------------*/

//visual del reloj del laberinto, se encarga de gestionar el tiempo de la partida.
object relojDePartida{
    method position() = game.at(game.width() - 21, game.height() - 3)
    const property image = "reloj-marco.png"
    var property tiempo = 45

    //Método que inicia un temporizador el cual va a reducir el tiempo restante cada segundo.
    method iniciarTemporizador() {
        self.configurarTiempo()
        game.onTick(1000, "reducir tiempo partida", {
            self.reducirTiempo()
        })
    }

    //Método que configura el tiempo inicial de la partida sumando el tiempo extra del arquetipo del personaje.
    method configurarTiempo(){
        tiempo = 45 + personaje.arquetipo().tiempoExtra()
    }

    //Método que aumenta el valor de la variable tiempo en 5s
    method sumarTiempo(){
        tiempo = self.tiempo() + 5
    }

    //Método que reduce el valor de la variable y si llega a 0 la reinicia e inicia la pantalla de game over.
    method reducirTiempo(){
        tiempo = (tiempo - 1).max(0)
        if (tiempo == 0){
            self.configurarTiempo()
            pantallaGameOver.iniciarAnimacion()
        }
    }
    
}

//visual del timer del marco, indica el tiempo restante para completar el nivel.
object timerTexto {

    //Método que devuelve la posición del timer en el marco.
    method position() = game.at(game.width() - 16, game.height() - 2)
    
    //Se coloca en el marco con reloj un texto que indica el tiempo restante en segundos.
    method text() = " " + relojDePartida.tiempo().toString() + " SEG..."

    //Este metodo asigna el color de la letra del timer.
    method textColor() = "#ffffff"
}
