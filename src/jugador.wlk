import juego.*
import arquetipos.*
import pantallas.*
import objetosAColisionar.*
import enemigos.*
import mapa.*
 


object personaje{
    var property position = game.at(2, 0)
    var property arquetipo = new ArquetipoPersonaje(image = "exploradora", vidasIniciales = 2, tiempoExtra = 30)
    var property vidas = 0
    var property direccion = "abajo"
    
    //Metodo que devuelve la cantidad de vidas que tiene el personaje actualmente.
    method vidas() {
        return vidas
    }

    //Metodo que suma una vida al personaje, pero no puede superar el maximo de 3 vidas.
    method sumarVida(){
        vidas = (self.vidas() + 1).min(3)
    }

    //Metodo que asigna la cantidad de vidas iniciales del personaje segun el arquetipo elegido.
    method asignarVida(){
        vidas = arquetipo.vidasIniciales()
    }


    var property puedeMover = false
    method image(){
        return  arquetipo.personajeImagen() + "-" + direccion + ".png"
    }
    method reiniciar() {
        position = game.at(2, 0)
        direccion = "abajo"
       
        vidas = arquetipo.vidasIniciales()
        cofreColocado.cofresAbiertos(0)
        self.asignarVida()
        self.puedeMover(true)
    }

    method aplicarStunInicial() {
        self.bloquearMovimiento()
        game.schedule(arquetipo.tiempoStun(), { self.desbloquearMovimiento() })
    }
    
    method elegirArquetipo(nuevoArquetipo){
        arquetipo = nuevoArquetipo
        vidas = arquetipo.vidasIniciales()
    }

   method recibirDanio(){
        vidas = vidas - 1
        if(vidas <= 0){
            game.say(self, "¡Me morí!")
            pantallaGameOver.iniciarAnimacion()
        }
   }

    



   method subir(){
    direccion = "arriba"
    const nuevaPosicion = position.up(1)
    
    if (puedeMover and nuevaPosicion.y() < game.height() and self.caminoLibre(nuevaPosicion)){
        position = nuevaPosicion
    }
   }

   method bajar(){
    direccion = "abajo"
    const nuevaPosicion = position.down(1)
    if (puedeMover and nuevaPosicion.y() >= 0 and self.caminoLibre(nuevaPosicion)){
        position = nuevaPosicion
    }
   }

   method izquierda(){
    direccion = "izquierda"
    const nuevaPosicion = position.left(1)
    if (puedeMover and nuevaPosicion.x() >= 0 and self.caminoLibre(nuevaPosicion)){
        position = nuevaPosicion
    }
   }

   method derecha(){
    direccion = "derecha"
    const nuevaPosicion = position.right(1)
    if (puedeMover and nuevaPosicion.x() < game.width() and self.caminoLibre(nuevaPosicion)){
        position = nuevaPosicion
    }
   }



   //establecer las colisiones de paredes (Integrante 3)
   method caminoLibre(unaPosicion) {
    return mapa.esPosicionLibre(unaPosicion)

}

method bloquearMovimiento() {
  puedeMover = false
  
}
method desbloquearMovimiento() {
  puedeMover = true
}

method activarColisiones() {
  game.onCollideDo(self, {o => o.colision()})
}


}