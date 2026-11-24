import wollok.game.*
import jugador.*

/*---------------------------------------------------------//Objetos con colisiones//---------------------------------------------------------*/


class ObjetosAColisionar {
    var property position

    method image()

    method colision() {
        self.efecto()
        game.say(personaje, self.mensaje())
        self.quitarObjeto()
    }

    method efecto()
    method mensaje()

    method quitarObjeto() { game.removeVisual(self) }
}

class Trampa inherits ObjetosAColisionar {
    var property visible = true

    override method image() = if (visible){"trampa_visible.png"}else{"trampa_invisible.png"}

    override method efecto() {
        personaje.bloquearMovimiento()
        game.schedule(2000, {personaje.desbloquearMovimiento()})
    }

    override method mensaje() = "No me puedo mover!!"
}

object trampaColocada {
  const posiciones = [game.at(2,3),game.at(4,3),game.at(3,6),game.at(11,19),
                      game.at(7,7),game.at(12,7),game.at(15,7),
                      game.at(2,17),game.at(23,2),game.at(26,4),game.at(5,14),
                      game.at(22,10),game.at(19,11),game.at(18,14),game.at(22,21),
                      game.at(27,17)]

  method mostrar() {
    posiciones.forEach({p =>
      const trampa_ = new Trampa(position = p)
      game.addVisual(trampa_)
      game.schedule(personaje.arquetipo().tiempoTrampa(), {trampa_.visible(false)})
    })
  }
}

class Cofres inherits ObjetosAColisionar {

    override method image() = "cofre.png"

    override method efecto() {
        self.quitarObjeto()
        cofreColocado.registrarCofreAbierto()
    }

    override method mensaje() =
        if (cofreColocado.tieneLaLlave()) "Encontré la llave. Ya puedo salir"
        else "Acá no esta la llave"
}

object cofreColocado {
  var property cofresAbiertos = 0
  const posiciones = [game.at(11,23), game.at(31,5), game.at(25,15)]

  method registrarCofreAbierto() { cofresAbiertos += 1 }

  method tieneLaLlave() = cofresAbiertos >= 3

  method mostrar() {
    cofresAbiertos = 0
    posiciones.forEach({p =>
      const cofre_ = new Cofres(position = p)
      game.addVisual(cofre_)
    })
  }
}