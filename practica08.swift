//Serhii Vidernikov

//Experimento 1

let constante: Float=4
//print(constante)

//Experimento 2

let etiqueta = "El ancho es "
let ancho = 94
let anchoEtiqueta = etiqueta + String(ancho)
//...+ancho -> error, no se puede aplicar + a String y Int

//Experimento 3

let nombre="Dani"
//print("Hola, me llamo \(nombre) y tengo \(constante) años")

//Experimento 4

var cadenaOpcional: String? = "Hola"
//print(cadenaOpcional == nil)

var nombreOpcional: String? = nil //= "John Appleseed"
var saludo = "Hola!"
if let nombre = nombreOpcional {
    saludo = "Hola, \(nombre)"
}
else{
    saludo = "Hola, desconocido"
}
//print(saludo)

//Experimento 5

/*let verdura = "pimiento rojo"
switch verdura {
    case "zanahoria":
        print("Buena para la vista.")
    case "lechuga", "tomates":
        print("Podrías hacer una buena ensalada.")
    default: //si lo quitamos aparece error por que switch no esta completo
        print("Siempre puedes hacer una buena sopa.")
}*/

//Experimento 6

let numerosInteresantes = [
    "Primos": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8, 13, 21, 34],
    "Cuadrados": [1, 4, 9, 16, 25],
]
var mayor = 0
for (clase, numeros) in numerosInteresantes {
    for num in numeros {
        if num > mayor {
            mayor = num
        }
    }
}
//print(mayor)

//Experimento 7

func saluda(nombre: String, comida: String) -> String {
    return "Hola \(nombre), comida de hoy es \(comida)."
}
//print(saluda(nombre: "Bob", comida: "pollo"))

//Experimento 8

func media(numeros: Int...) -> Int {
    var media = 0
    var contador = 0
    for num in numeros {
        media += num
        contador += 1
    }
    media = media / contador

    return media
}


print(media(numeros: 42, 597, 12))

//Experimento 9
var numeros = [20, 19, 7, 12]
numeros.map({
    (numero: Int) -> Int in
    var resultado = 0
    if numero % 2 == 0{
        resultado = numero
    }
    //print(resultado)
    return resultado
})