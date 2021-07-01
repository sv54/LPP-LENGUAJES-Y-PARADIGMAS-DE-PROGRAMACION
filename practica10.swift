import Foundation

//Practica 10

//Ejercicio 1
// a)

func maxOpt(_ x: Int?, _ y: Int?) -> Int?{
    if (x == nil && y != nil ){
        return y
    }
    if (x != nil && y == nil ){
        return x
    }
    if (x == nil && y == nil ){
        return nil
    }
    else{
        if x! < y!{
            return y
        }
        if x! > y!{
            return x
        }
        else {
            return y
        }
    }
}

let res1 = maxOpt(nil, nil) 
let res2 = maxOpt(10, nil)
let res3 = maxOpt(-10, 30)
/*print("res1 = \(String(describing: res1))")
print("res2 = \(String(describing: res2))")
print("res3 = \(String(describing: res3))")*/

// b)


func mayorParImpar2(numero: Int, pareja: (Int?, Int?)) -> (Int?, Int?) {
    if (numero.isMultiple(of: 2)) {
        return (pareja.0, maxOpt(pareja.1, numero))
    } else {
        return (maxOpt(pareja.0, numero), pareja.1)
    }
}

func parejaMayorParImpar2(numeros:[Int]) -> (Int?, Int?) {
    if (numeros.isEmpty) {
        return (nil, nil)
    } else {
        let primero = numeros[0]
        let resto = Array(numeros.dropFirst())
        let parejaResto = parejaMayorParImpar2(numeros: resto)
        return mayorParImpar2(numero: primero, pareja: parejaResto)
    }
}
let numeros = [-10, 202, 12, 100, 204, 2]
//print(parejaMayorParImpar2(numeros: numeros))


//b2)

func sumaMaxParesImpares(numeros: [Int]) -> Int{
    let pareja = parejaMayorParImpar2(numeros: numeros)

    if let num = pareja.0 , let num2 = pareja.1 {
        return num + num2
    }
    
    if let num = pareja.1{
        return num
    }
    if let num = pareja.0{
        return num
    }
    else {
        return 0
    }
}
//print("\n******\n1b2) Función sumaMaxParesImpares(numeros:)\n******")
/*print(sumaMaxParesImpares(numeros: numeros))
print("Ejemplo sin ningún número par:")
print(sumaMaxParesImpares(numeros: [11, -7, 23, 101]))
print("Ejemplo sin ningún número impar:")
print(sumaMaxParesImpares(numeros: [12, -8, 22, 100]))
print("Ejemplo con array vacío")
print(sumaMaxParesImpares(numeros: []))*/

// Ejercicio 2

// c)

func suma(palabras: [String] , contienen: Character) -> Int{
    palabras.filter{$0.contains(contienen)}.map{$0.count}.reduce(0,+)
}

let cadenas = ["hola" , "adios", "que"]
//print(suma(palabras: cadenas, contienen: "a"))
// Imprime: 9

func sumaMenoresMayores(nums: [Int] , pivote: Int) -> (Int, Int){
    return (nums.filter{$0 < pivote}.reduce(0, +) , nums.filter{$0 > pivote}.reduce(0, +))
}

let numerosMenorMayor = [1, 5, 10, 72, 12, 2]
//print(sumaMenoresMayores(nums: numerosMenorMayor, pivote: 6))



// Ejercicio 3



indirect enum Arbol <T> {
    case nodo(T,[Arbol])
}

func toArray<T> (arbol: Arbol<T>) -> [T] {
    switch arbol {
    case let .nodo(dato, hijos):
        return [dato] + toArray1(hijos: hijos)
    }
}

func toArray1<T>(hijos: [Arbol<T>]) -> [T]{
    if let primero = hijos.first {
        let resto = Array(hijos.dropFirst())
        return toArray(arbol: primero) + toArray1(hijos: resto)
    }
    else{
        return []
    }
}

func toArrayFOS<T>(arbol: Arbol<T>) -> [T]{
    switch arbol{
        case let .nodo(dato, hijos):
        return hijos.map(toArrayFOS).reduce([dato], +) 
    }
} 

let arbolInt: Arbol = .nodo(53, 
                            [.nodo(13, []), 
                             .nodo(32, []), 
                             .nodo(41, 
                                   [.nodo(36, []), 
                                    .nodo(39, [])
                                   ])
                            ])
let arbolString: Arbol = .nodo("Zamora", 
                               [.nodo("Buendía", 
                                      [.nodo("Albeza", []), 
                                       .nodo("Berenguer", []), 
                                       .nodo("Bolardo", [])
                                      ]), 
                                .nodo("Galván", [])
                               ])

//print(toArray(arbol: arbolInt))
//print(toArrayFOS(arbol: arbolString))

//Ejercicio 5

typealias Calificacion = (nombre: String, 
                          parcial1: Double,
                          parcial2: Double,
                          parcial3: Double,
                          años: Int)

// Función auxiliar que calcula la nota final
func notaFinal(_ calificacion: Calificacion) -> Double {
  return calificacion.parcial1 * 0.34 + 
         calificacion.parcial2 * 0.33 + 
         calificacion.parcial3 * 0.33
}

func imprimirListadoAlumnos(_ alumnos: [Calificacion]) {
    print("Alumno   Parcial1   Parcial2   Parcial3  Años")
    for alu in alumnos {
        alu.0.withCString {
            print(String(format:"%-10s %5.2f      %5.2f    %5.2f  %3d", $0, 
                        alu.parcial1, alu.parcial2, alu.parcial3, alu.años))
        }
    }
}

func imprimirListadosNotas(_ alumnos: [Calificacion]) {
    var alumnosOrdenados: [Calificacion]

    print("LISTADO ORIGINAL")
    imprimirListadoAlumnos(alumnos)

    print("LISTADO ORDENADO por Nombre")
    alumnosOrdenados = alumnos.sorted(by: 
                 {a1, a2 in a1.nombre < a2.nombre})
    imprimirListadoAlumnos(alumnosOrdenados)

}

let listaAlumnos: [Calificacion] = [
                    ("Pepe", 8.45, 3.75, 6.05, 1), 
                    ("Maria", 9.1, 7.5, 8.18, 1), 
                    ("Jose", 8.0, 6.65, 7.96, 1),
                    ("Carmen", 6.25, 1.2, 5.41, 2), 
                    ("Felipe", 5.65, 0.25, 3.16, 3), 
                    ("Carla", 6.25, 1.25, 4.23, 2), 
                    ("Luis", 6.75, 0.25, 4.63, 2), 
                    ("Loli", 3.0, 1.25, 2.19, 3)]
//imprimirListadosNotas(listaAlumnos)


//Ejercicio 5


//print(listaAlumnos.filter{$0.parcial1 >= 5 && $0.parcial2 < 5}.count )

//print(listaAlumnos.map {(alumno) -> (String, Double) in 
//            let nota = notaFinal(alumno)
//            return (alumno.nombre, nota)}.filter {$0.1 >= 5}.map {$0.0})

//var tupla = listaAlumnos.reduce((0,0,0), {(result, alumno) in 
//                                         return (result.0 + alumno.parcial1, 
//                                                 result.1 + alumno.parcial2, 
//                                                 result.2 + alumno.parcial3)
//})
//tupla = (tupla.0 / Double(listaAlumnos.count), tupla.1 / Double(listaAlumnos.count), tupla.2 / Double(listaAlumnos.count))
//print(tupla)



func construye(operador: Character) -> (Int, Int) -> Int{
    return {(p1: Int, p2: Int) -> Int in 
        switch operador {
            case "*": 
                return p1 * p2
            case "/":
                return p1 / p2
            case "-":
                return p1 - p2
            default:
                return p1 + p2} 
}
}

var f = construye(operador: "+")
print(f(2,3))
// Imprime 5
f = construye(operador: "-")
print(f(2,3))





