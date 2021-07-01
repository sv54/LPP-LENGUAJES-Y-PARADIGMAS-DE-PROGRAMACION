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
print(sumaMenoresMayores(nums: numerosMenorMayor, pivote: 6))
