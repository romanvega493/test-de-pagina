import wollok.game.*

//Este objeto representa las paredes del mapa, contiene la matriz con las paredes y los métodos para construir el laberinto y verificar colisiones.

object mapa {
  var grilla = []
  var inicializado = false

  /*---------------------------------------------------------//Colisiones//---------------------------------------------------------*/
  
  //Método para inicializar la matriz de paredes del laberinto. Se llama al iniciar el juego.
  method inicializarParedes() {

    //Si las paredes no fueron construidas, se construyen y se marca como inicializado para no volver a construirlas.
    if (not inicializado) {

      //Se carga una matriz con todas las posiciones libres (true) y luego se construye el laberinto.
      grilla = (0..24).map({ y => (0..32).map({ x => true }) })
      
      //Se construyen las paredes del laberinto modificando la matriz que tenia todas las posiciones libres.
      self.construir()

      //Se marca como inicializado para no volver a construir las paredes.
      inicializado = true
    }
  }

  //Método que agrega una pared en la posición indicada, modificando la matriz.
  method agregarPared(x, y) {
    
    //Se obtiene la fila vieja de la matriz.
    const filaVieja = grilla.get(y)

    //Se crea una nueva fila con la posición indicada como bloqueada (false) y el resto de las posiciones se mantienen iguales(filaVieja).
    const filaNueva = (0..32).map({ col => if (col == x) false else filaVieja.get(col) })

    //Se reemplaza la fila vieja por la nueva en la matriz.
    grilla = (0..24).map({ fila => if (fila == y) filaNueva else grilla.get(fila) })
  }

  //Método que agrega una fila de paredes en las posiciones indicadas, modificando la matriz.
  method agregarFila(xs, y) {

    //Se asigna el valor mínimo y máximo de las posiciones recibidas para agregar la fila de paredes.
    const desde = xs.min()
    const hasta = xs.max()

    //Se obtiene la fila vieja de la matriz.
    const filaVieja = grilla.get(y)

    //Se crea una nueva fila con las posiciones indicadas como bloqueadas (false) y el resto de las posiciones se mantienen iguales(filaVieja).
    const filaNueva = (0..32).map({ col => if (col.between(desde, hasta)) false else filaVieja.get(col) })

    //Se reemplaza la fila vieja por la nueva en la matriz.
    grilla = (0..24).map({ fila => if (fila == y) filaNueva else grilla.get(fila) })
  }

  //Método que agrega una columna de paredes en las posiciones indicadas, modificando la matriz.
  method agregarColumna(x, ys) {

    //Se asigna el valor mínimo y máximo de las posiciones recibidas para agregar la columna de paredes.
    const desde = ys.min()
    const hasta = ys.max()

    //Se reemplaza la columna vieja por la nueva en la matriz.
    grilla = (0..24).map({ fila =>
      if (fila.between(desde, hasta)) {
        const filaVieja = grilla.get(fila)
        (0..32).map({ col => if (col == x) false else filaVieja.get(col) })
      } else {
        grilla.get(fila)
      }
    })
  }

  //Método que devuelve true si la posición indicada está libre, false si está bloqueada por una pared.
  method esPosicionLibre(pos) = grilla.get(pos.y()).get(pos.x())



  /*---------------------------------------------------------//Construcción del Laberinto//---------------------------------------------------------*/

  //Método que construye las paredes del laberinto agregandolas a la grilla.
  method construir() {
    // bordes limites
    self.agregarFila(0..32, 24)
    self.agregarFila(0..1, 0)
    self.agregarFila(6..32, 0)
    self.agregarColumna(0, 0..24)
    self.agregarColumna(32, 0..24)

    // paredes horizontales internas del laberinto
    [12..21, 27..28, 30..31].forEach({ xs =>
      self.agregarFila(xs, 23)
      self.agregarFila(xs, 22)
    })
    self.agregarFila(4..8, 22)
    self.agregarFila(23..27, 20)
    self.agregarFila(4..6, 17)
    self.agregarFila(6..8, 16)
    self.agregarFila(13..17, 14)
    self.agregarFila(20..23, 14)
    self.agregarFila(26..31, 13)
    self.agregarFila(25..26, 12)
    self.agregarFila(10..17, 11)
    self.agregarFila(23..25, 10)
    self.agregarFila(3..7, 9)
    self.agregarFila(30..31, 6)
    self.agregarFila(6..18, 4)
    self.agregarFila(20..25, 4)
    self.agregarFila(28..30, 4)

    /*paredes verticales internas del laberinto*/

    self.agregarColumna(4, 18..21)
    self.agregarColumna(7, 10..12)
    self.agregarColumna(8, 14..15)
    self.agregarColumna(13, 15..16)
    self.agregarColumna(16, 12..13)
    self.agregarColumna(17, 15..16)
    self.agregarColumna(20, 5..10)
    self.agregarColumna(23, 15..19)

    // paredes individuales
    self.agregarPared(6, 1)
    self.agregarPared(25, 11)
    self.agregarPared(30, 5)
    self.agregarPared(31, 7)
    self.agregarPared(30, 8)
  }
}