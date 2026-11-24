import wollok.game.*
import mapa.*
import jugador.*

/*---------------------------------------------------------//Enemigos Del Juego//---------------------------------------------------------*/

//Clase madre que representa un enemigo, se encarga de definir los atributos y comportamientos del enemigo.
class Enemigo {
	var property position
	var property activo = true

	//Método abstracto para no instanciar la clase, cada hijo se encargara de resolver el método.
	method image()

	//Método que mueve al enemigo si esta activo.
	method mover() {
		if (activo) {
			self.ejecutarRutinaMovimiento()
		}
	}

	//Método abstracto para no instanciar la clase, cada hijo se encargara de resolver el método.
	method ejecutarRutinaMovimiento()

	//Método que mueve al enemigo a la ubicación dada si es posible sino produce la acción de chocar con una pared.
	method intentarMoverA(nuevaPosicion) {
		if (self.esPosicionValida(nuevaPosicion)) {
			position = nuevaPosicion
		} else {
			self.alChocarConPared()
		}
	}

	//Método que indica si la posicion dada es válida.
	method esPosicionValida(pos) {
		const dentroDeLimites = pos.x().between(0, game.width() - 1) and pos.y().between(0, game.height() - 1)
		const estaBloqueada = !mapa.esPosicionLibre(pos)
		return dentroDeLimites and not estaBloqueada
	}

	//Método que se ejecuta al chocar con una pared, puede ser sobreescrito por las subclases para definir un comportamiento específico.
	method alChocarConPared() {}

	//Método que se ejecuta al colisionar con el personaje, llama al método **atacar** del enemigo delegando responsabilidades.
	method colision() {
		self.atacar(personaje)
	}

	//Método que ataca al jugador, delegando la responsabilidad de recibir daño al jugador.
	method atacar(unJugador) {
		if (activo) {
			unJugador.recibirDanio()
		}
	}

	//Método que detiene el comportamiento del enemigo, eliminando el evento de tick del juego.
	method detener() {
		activo = false
		game.removeTickEvent("mover_" + self.identity())
	}

	//Método que inicia el comportamiento del enemigo, agregando un evento de tick al juego para que se mueva según la cantidad de milisegundos indicados.
	method iniciarComportamiento(frecuenciaMs) {
		game.onTick(frecuenciaMs, "mover_" + self.identity(), { self.mover() })
	}
}

//Clase que representa un murciélago, hereda de Enemigo, se encarga de definir los atributos y comportamientos del murciélago.
class Murcielago inherits Enemigo {
	var direccion = derecho

	//Método que devuelve la imagen dependiendo la dirección del murcielago.
	override method image() = "murcielago" + direccion.sufijoImagen() + ".png"

	//Método que ejecuta el movimiento del murcielago.
	override method ejecutarRutinaMovimiento() {
		const nuevaPos = direccion.siguientePosicion(position)
		self.intentarMoverA(nuevaPos)
	}

	//Método que reescribe la direccion del murcielago.
	override method alChocarConPared() {
		direccion = direccion.opuesta()
	}
}

//Clase que representa un esqueleto, hereda de Enemigo, se encarga de definir los atributos y comportamientos del esqueleto.
class Esqueleto inherits Enemigo {
	var property rangoPersecucion = 5
	var property objetivo = null
	var direccion = abajo

	//Método que devuelve la imagen dependiendo la dirección del esqueleto.
	override method image() = "esqueleto" + direccion.sufijoImagen() + ".png"

	//Método que ejecuta el movimiento del esqueleto.
	override method ejecutarRutinaMovimiento() {
		if (self.puedeYDebePerseguir()) {
			self.perseguir(objetivo.position())
		} else {
			self.patrullarAleatorio()
		}
	}

	//Método que indica si la distancia del **esqueleto** respecto del **personaje** es inferior al **rangoPersecucion**
	method puedeYDebePerseguir() = objetivo != null and position.distance(objetivo.position()) <= rangoPersecucion

	//Método que ejecuta la acción de perseguir al **personaje**.
	method perseguir(posObjetivo) {
		const diffX = posObjetivo.x() - position.x()
		const diffY = posObjetivo.y() - position.y()

		if (diffX.abs() >= diffY.abs()) {
			direccion = if (diffX > 0) derecho else izquierdo
		} else {
			direccion = if (diffY > 0) arriba else abajo
		}

		self.intentarMoverA(direccion.siguientePosicion(position))
	}

	//Método que ejecuta la acción de patrullar aleatoriamente.
	method patrullarAleatorio() {
		direccion = direcciones.aleatoria()
		self.intentarMoverA(direccion.siguientePosicion(position))
	}

	//Método que asigna la frecuencia de ejecución del comportamiento del esqueleto reutilizando el método de la clase madre.
	override method iniciarComportamiento(frecuenciaMs) {
		super(frecuenciaMs + 237)
	}
}


object direcciones {
	method todas() = [derecho, izquierdo, arriba, abajo]
	method aleatoria() = self.todas().anyOne()
}

object derecho {
	method siguientePosicion(pos) = game.at(pos.x() + 1, pos.y())
	method opuesta() = izquierdo
	method sufijoImagen() = "-derecha"
}

object izquierdo {
	method siguientePosicion(pos) = game.at(pos.x() - 1, pos.y())
	method opuesta() = derecho
	method sufijoImagen() = "-izquierda"
}

object arriba {
	method siguientePosicion(pos) = game.at(pos.x(), pos.y() + 1)
	method opuesta() = abajo
	method sufijoImagen() = "-arriba"
}

object abajo {
	method siguientePosicion(pos) = (game.at(pos.x(), pos.y() - 1))
	method opuesta() = arriba
	method sufijoImagen() = ""
}