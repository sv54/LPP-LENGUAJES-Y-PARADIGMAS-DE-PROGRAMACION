import Foundation


//Ejercicio 1 b

struct Coord {
    var x: Double
    var y: Double

    func movida(incX: Double, incY: Double) -> Coord {
        return Coord(x: x+incX, y: y+incY)
    }

    mutating func mueve(incX: Double, incY: Double) {
        x = x + incX
        y = y + incY
    }
}

struct Cuadrado {
    var esquina = Coord(x: 0.0, y: 0.0)
    var lado: Double

    func movido1 (incX: Double, incY: Double) -> Cuadrado{
        let cuadrado = Cuadrado(esquina: self.esquina.movida(incX: incX, incY: incY), lado: self.lado)
        return cuadrado
    }

    func movido2 (incX: Double, incY: Double) -> Cuadrado{
        var cuadrado = self
        cuadrado.esquina.mueve(incX: incX, incY: incY)
        return cuadrado
    }
}

struct Valor {
    var valor: Int = 0 {
        willSet {
            Valor.z += newValue
        }        
        didSet {
            if valor > 10 {
                valor = 10
            }
        }
    }
    static var z = 0
}

var c1 = Valor()
var c2 = Valor()
c1.valor = 20
c2.valor = 8
print(c1.valor + c2.valor + Valor.z)



//Ejercicio 3, partidos de futbol utilizando structs

struct Equipo{
    var nombre: String
    var puntos = 0

    mutating func puntuacion(incrementar en: Int){
        puntos += en
    }
}

struct Partido {
    var nombre1: String
    var nombre2: String
    var puntos1: Int
    var puntos2: Int
}

struct Liga {
    var equipos: [Equipo]
    var partidos: [Partido]

    func puntuaciones() {
        for e in equipos{
            print("\(e.nombre): \(e.puntos)")
        }
    }

    func partidos() {
        for p in partidos{
            print("\(p.nombre1) \(p.puntos1) - \(p.puntos2) \(p.nombre2)")
        }
    }

    //Sin acabar
}

import Foundation


//Ejercicio 4

struct Punto {
    var x = 0.0, y = 0.0
}
struct Tamaño {
    var ancho = 0.0, alto = 0.0
}

class Figura {
    origen: Punto
    tamaño: Tamaño

    var area: Double {
        get{
            tamaño.ancho * tamaño.alto
        }
    }

    var centro: Punto{
        get{
            centro.x = origen.x + tamaño.ancho / 2
            centro.y = origen.y + tamaño.ancho / 2
            return Punto(x: centro.x, y: centro.y)
        }
        set{
            origen.x = newValue.x - (tamaño.ancho / 2)
            origen.y = newValue.y - (tamaño.alto / 2)
        }
    }
    init(origen: Punto, tamaño: Tamaño) {
      self.origen = origen
      self.tamaño = tamaño
    }
} 

class Cuadrilatero: Figura {
    var p1, p2, p3, p4: Punto
    override var centro: Punto{
        get {
            super.centro
        }
        set {
            let incX = newValue.x - centro.x
            let incY = newValue.y - centro.y
            // Se llama al setter de la figura
            super.centro = newValue
            // Se actualiza las coordenadas de los puntos
            p1 = Punto(x: p1.x + incX, y: p1.y + incY)
            p2 = Punto(x: p2.x + incX, y: p2.y + incY)
            p3 = Punto(x: p3.x + incX, y: p3.y + incY)
            p4 = Punto(x: p4.x + incX, y: p4.y + incY)
        }
    }
     override var area: Double {
        let areaTriangulo1 = areaTriangulo(p1, p2, p3)
        let areaTriangulo2 = areaTriangulo(p3, p4, p1)
        return areaTriangulo1 + areaTriangulo2
    }

    init(p1: Punto, p2: Punto, p3: Punto, p4: Punto) {
        self.p1 = p1
        self.p2 = p2
        self.p3 = p3
        self.p4 = p4
        let minX = min(p1.x, p2.x, p3.x, p4.x)
        let minY = min(p1.y, p2.y, p3.y, p4.y)
        let maxX = max(p1.x, p2.x, p3.x, p4.x)
        let maxY = max(p1.y, p2.y, p3.y, p4.y)
        let alto = maxY - minY
        let ancho = maxX - minX
        super.init(origen: Punto(x: minX, y: minY), tamaño: Tamaño(ancho: ancho, alto: alto))
    }
}

class Circulo: Figura {
    var radio: Double {
        didSet {
            let incRadio = radio - oldValue
            origen.x -= incRadio
            origen.y -= incRadio
            let alto = radio * 2
            let ancho = radio * 2
            tamaño = Tamaño(ancho: ancho, alto: alto)
        }
    }
    override var area: Double {
        get {
            Double.pi * radio * radio
        }
        set {
            let radioCuadrado = newValue / Double.pi
            radio = radioCuadrado.squareRoot()
        }
    } 

    init(centro: Punto, radio: Double) {
        self.radio = radio
        let minX = centro.x - radio
        let minY = centro.y - radio
        let alto = radio * 2
        let ancho = radio * 2
        super.init(origen: Punto(x: minX, y: minY), tamaño: Tamaño(ancho: ancho, alto: alto))
    }
}

struct AlmacenFiguras {
    var figuras = [Figura]()

    var numFiguras: Int {
        return figuras.count
    }

    var areaTotal: Double {
        return figuras.reduce(0) {$0 + $1.area}
    }

    mutating func añade(figura: Figura) {
        figuras.append(figura)
    }

    mutating func desplaza(incX: Double, incY: Double) {
        for figura in figuras {
            let centro = figura.centro
            let nuevoCentro = Punto(x: centro.x + incX, y: centro.y + incY)
            figura.centro = nuevoCentro
        }
    }
}









