import Foundation

//practica 9

//  Ejercicio 1
// a)

func prefijos(prefijo: String, palabras: [String]) -> [Bool]{
    if palabras.count == 0{
        return []
    }
    return [palabras[0].hasPrefix(prefijo)] + prefijos(prefijo: prefijo, palabras: Array(palabras.dropFirst()))
}

let array = ["anterior", "antígona", "antena"]
let prefijo = "ante"
//print(prefijos(prefijo: prefijo, palabras: array))

//b)

func mayorParImpar(numero: Int, pareja: (Int, Int)) -> (Int, Int) {
    if (numero.isMultiple(of: 2)) {
        return (pareja.0, max(pareja.1, numero))
    } else {
        return (max(pareja.0, numero), pareja.1)
    }
}

func parejaMayorParImpar(numeros:[Int]) -> (Int, Int) {
    if (numeros.isEmpty) {
        return (0, 0)
    } else {
        let primero = numeros[0]
        let resto = Array(numeros.dropFirst())
        let parejaResto = parejaMayorParImpar(numeros: resto)
        return mayorParImpar(numero: primero, pareja: parejaResto)
    }
}

let numeros = [10, 201, 12, 103, 204, 2]

//Ejercicio 2
func cuadrado(x: Int) -> Int {
   return x * x
}

func compruebaParejas(_ num: [Int] , funcion: (Int) -> Int) -> [(primer: Int, segundo: Int)]{
    if num.count == 2{
        if(num[1] == funcion(num[0])){
            return [(num[0],num[1])]
        }
        else{
            return []
        }
    }
    let primer = num[0]
    let segundo = num[1]
    if(num[1] == funcion(primer)){
        return [(primer,segundo)] + compruebaParejas(Array(num.dropFirst()), funcion: funcion)
    }
    else{
        return [] + compruebaParejas(Array(num.dropFirst()), funcion: funcion)
    }

}
//print(compruebaParejas([2, 4, 16, 5, 10, 100, 105], funcion: cuadrado))

//b)

func coinciden(parejas: [(car: Int, cdr: Int)], funcion: (Int)->Int) -> [Bool]{
    if parejas.count == 1{
        if(parejas[0].cdr == funcion(parejas[0].car)){
            return [true]
        }
        else{
            return [false]
        }
    }
    let primer = parejas[0].car
    let segundo =  parejas[0].cdr
    let resto = Array(parejas.dropFirst())
    if(segundo == funcion(primer)){
        return [true] + coinciden(parejas: resto, funcion: funcion)
    }
    else{
        return [false] + coinciden(parejas: resto, funcion: funcion)
    }

}
let arr = [(2,4), (4,14), (4,16), (5,25), (10,100)]
//print(coinciden(parejas: arr, funcion: cuadrado))
// Imprime: [true, false, true, true, true]

// Ejercicio 3
enum CodigoBarras {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

enum Movimiento {
    case deposito(Double)
    case cargoRecibo(String, Double)
    case cajero(Double)
}

func aplica(movimientos: [Movimiento] ) -> (Double , str: [String]){
    var suma: Double = 0
    var str = [String]()
    for mov in movimientos{
        switch mov {

           case let .deposito(mov):
               suma += mov
           case let .cargoRecibo(recibo , mov):
               suma = suma - mov
               str.append(recibo) 
           case let .cajero(mov):
               suma -= mov
        }
    }
    return (suma, str)
}

let movimientos: [Movimiento] = [.deposito(830.0), .cargoRecibo("Gimnasio", 45.0), .deposito(400.0), .cajero(100.0), .cargoRecibo("Fnac", 38.70)]
//print(aplica(movimientos: movimientos))

// Ejercicio 4
indirect enum ArbolBinario {
    case nodo(Int , ArbolBinario, ArbolBinario)
    case vacio
}

func suma(arbolb: ArbolBinario) -> Int{
    switch arbolb {
    case .vacio:
        return 0
    case let .nodo(dato, iz, de):
        return dato + suma(arbolb: iz) + suma(arbolb: de)
    }
}
let arbol: ArbolBinario = .nodo(8, 
                                .nodo(2, .vacio, .vacio), 
                                .nodo(12, .vacio, .vacio))
                                
//print(suma(arbolb: arbol))

//Ejercicio 5
indirect enum Arbol{
    case nodo(Int , [Arbol])
}

func suma(arbol: Arbol,  cumplen: (Int) -> Bool) -> Int{
    switch arbol{
        case let .nodo(dato, bosque):
        if cumplen(dato){
            return dato + suma(bosque: bosque, cumplen: cumplen)  
        }
        return suma(bosque: bosque, cumplen: cumplen)
    }
}

func suma(bosque: [Arbol], cumplen: (Int) -> Bool) -> Int{
    if bosque.count == 0{
        return 0
    }
    return suma(arbol: bosque[0], cumplen: cumplen) + suma(bosque: Array(bosque.dropFirst()), cumplen: cumplen)
}

let arbol1 = Arbol.nodo(1, [])
let arbol3 = Arbol.nodo(3, [arbol1])
let arbol5 = Arbol.nodo(5, [])
let arbol8 = Arbol.nodo(8, [])
let arbol10 = Arbol.nodo(10, [arbol3, arbol5, arbol8])

func esPar(x: Int) -> Bool {
    return x % 2 == 0
}

print("La suma del árbol es: \(suma(arbol: arbol10, cumplen: esPar))")




