#lang racket
(require rackunit)
(require graphics/turtles)
;;Binario a decimal

(define (binades b1 b2 b3 b4)
  (+ (* b1 (expt 2 3)) (* b2 (expt 2 2)) (* b3 (expt 2 1)) (* b4 (expt 2 0))))


;; Minimo

(define(minimo1 a b) (if(< a b)a b))

(define (minimo lista)
  (if (null? (cdr lista))(car lista) (minimo1(car lista) (minimo (cdr lista)))))


(check-equal? (minimo '(1 -1 3 -6 4)) -6)

(define (concatena lista)
  (if (null? lista) ""
  (string-append (string (car lista)) (concatena (cdr lista)))))

;(concatena '(#\S #\c #\h #\e #\m #\e #\space #\m #\o #\l #\a))

(define (bindes2 lista)
  (if(null? lista)
     0
     (+ (*(car lista) (expt 2 (- (length lista) 1))) (bindes2 (cdr lista)))))

;(bindes2 '(1 1 1 1 1 1 1 1))


;;(define p1 (list (cons 1 2) (list 3 4)))


(define (suma-izq pareja n)
  (cons (+ (car pareja) n) (cdr pareja)))

(define (suma-der pareja n)
  (cons (car pareja) (+ (cdr pareja) n)))

(suma-izq (cons 10 20) 3)  ; ⇒ (13 . 20)
(suma-der (cons 10 20) 5)  ; ⇒ (10 . 25)

(define(suma-impares-pares lista)
  (cond ((null? lista) (cons 0 0))
        ((odd? (car lista)) (suma-izq(suma-impares-pares (cdr lista)) (car lista)))
        (else (suma-der(suma-impares-pares (cdr lista)) (car lista)))))


(check-equal? (suma-impares-pares '(3 2 1 4 8 7 6 5)) '(16 . 20))
(check-equal? (suma-impares-pares '(3 1 5)) '(9 . 0))


;;Mayor cadena y su longitud
(define (mejor-cadena pareja cadena)
  (if (> (string-length cadena)
         (cdr pareja))
      (cons cadena (string-length cadena))
      pareja))

(define (cadena-mayor lista)
  (if (null? lista)
      (cons "" 0)
      (mejor-cadena (cadena-mayor (cdr lista)) (car lista))))

;;(cadena-mayor '("vamos" "a" "obtener" "la" "cadena" "mayor")) ; ⇒  ("obtener" . 7)
;;(cadena-mayor '("prueba" "con" "maximo" "igual")) ; ⇒ ("maximo" . 6)
;;(cadena-mayor '()) ; ⇒ ("" . 0)


;;Es prefijo Practica 3
(define (es-prefijo pal1 pal2)
  (if(and (<= (string-length pal1) (string-length pal2))
          (string=? pal1 (substring pal2 0 (string-length pal1)))) #t #f))


(define (contiene-prefijo prefijo lista)
  (if (null? lista)
      '()
      (cons (es-prefijo prefijo (car lista)) (contiene-prefijo prefijo (cdr lista)))))

(check-true (es-prefijo "" "algo"))
(check-true (es-prefijo "ante" "anterior"))
(check-false (es-prefijo "antena" "anterior"))
(check-false (es-prefijo "antena" "ante"))

;(contiene-prefijo "ante" '("anterior" "antígona" "antena" "anatema")) 


(define (inserta-pos dato pos lista)
  (if(= pos 0) (cons dato lista) (cons (car lista)(inserta-pos dato (- pos 1)(cdr lista)))))

;;(inserta-pos 'b 2 '(a a a a)) ; ⇒ '(a a b a a)

;;ordenar y insertar

(define (inserta-ordenada dato lista)
  (cond ((null? lista) (cons dato lista))
        ((> (car lista) dato) (cons dato lista))
        (else (cons (car lista)(inserta-ordenada dato (cdr lista))))))

;(inserta-ordenada 10 '(-8 2 3 11 20)) ; ⇒ (-8 2 3 10 11 20)

(define (ordena lista)
  (if(null? lista) '() (inserta-ordenada (car lista) (ordena (cdr lista)))))


;;(ordena '(2 -1 100 4 -6)) ; ⇒ (-6 -1 2 4 100)


;;Potencias
(define (combina-elemento elemento lista-conjuntos)
  (if (null? lista-conjuntos)
      '()
      (cons (cons elemento
                  (car lista-conjuntos))
            (combina-elemento elemento
                            (cdr lista-conjuntos)))))

(check-equal? (combina-elemento 'a '((b c) (b) (c) ())) '((a b c) (a b) (a c) (a)))

(define (amplia-potencia elemento lista-conjuntos)
  (append (combina-elemento elemento lista-conjuntos)
          lista-conjuntos))

(check-equal? (amplia-potencia 'a '((b c) (b) (c) ()))
              '((a b c) (a b) (a c) (a) (b c) (b) (c) ()))

(define (conjunto-potencia lista)
  (if (null? lista)
      (list '())
      (amplia-potencia (car lista)
                       (conjunto-potencia (cdr lista)))))

;;(conjunto-potencia '(a b c d))
              



;; LAMBDA
(define suma-3 (lambda (x)
   (+ x 3)))


(define factorial(lambda (x)
   (if (= x 0)
      1
      (* x (factorial (- x 1))))))


(define (doble x)
   (* 2 x))

(define (foo f g x y)
   (f (g x) y))

(define (bar f p x y)
   (if (and (p x) (p y))
       (f x y)
       'error))


;(foo + doble 10 15) ; ⇒ ?
;(foo string-append (lambda (x) (string-append "***" x)) "Hola" "Adios") ; ⇒ ?


;;(bar string-append string? "Hola" "Adios") ; ⇒ ?
;;(bar + number? "Hola" 5) ; ⇒ ?



(define (filtra-simbolos listas listan)
  (cond ((null? listas) '())
        ((= (string-length(symbol->string (car listas))) (car listan))
         (cons (cons (car listas) (car listan)) (filtra-simbolos (cdr listas) (cdr listan))))
        (else (filtra-simbolos (cdr listas) (cdr listan)))
        ))


;;(filtra-simbolos '(este es un ejercicio de examen) '(2 1 2 9 1 6))



;;Practica 4 !!!!!!!!

;;Ejercicio 3

(define (suma-n-izq dato lista) (map (lambda (pareja) (cons (+(car pareja) dato) (cdr pareja))) lista ))

;;(suma-n-izq 10 '((1 . 3) (0 . 9) (5 . 8) (4 . 1)))

(define (aplica-2 f lista)(map (lambda (pareja) (f (car pareja) (cdr pareja))) lista))

;(aplica-2 + '((2 . 3) (1 . -1) (5 . 4)))
;(aplica-2 (lambda (x y) (if (even? x) y (* y -1))) '((2 . 3) (1 . 3) (5 . 4) (8 . 10)))



; Función auxiliar que devuelve la parte derecha
; de una pareja si la parte izquierda es #t. Sino
; devuelve #f

(define (devuelve-si-existe pareja)
   (if (car pareja) (cdr pareja) #f))

(define (mi-index-of lista dato)
  (devuelve-si-existe 
   (foldl (lambda (elemento resultado)
            (cond
              ((car resultado) resultado) ; el car es #t: hemos encontrado el dato
                                          ; y no modificamos el resultado
              ((equal? dato elemento) (cons #t (cdr resultado))) ; encontramos el dato: construimos
                                                                    ; la pareja con #t y la posición actual
              (else (cons #f (+ (cdr resultado) 1))))) ; no es el dato: construimos la pareja con
                                                       ; #f e incrementamos el resultado
          (cons #f 0)  ; resultado inicial: pareja con #f (no encontrado) y 0 (posición inicial)
          lista)))
;(mi-index-of '(a b c d c) 'c) ; ⇒ 2
;(mi-index-of '(1 2 3 4 5) 10) ; ⇒ #f


(define (busca-mayor mayor? lista)
  (foldl (lambda (dato resultado)
           (if (mayor? dato resultado)
               dato
               resultado))
         (car lista) (cdr lista)))

(check-equal? (busca-mayor > '(8 3 4 1 9 6 2)) 9)
(check-equal? (busca-mayor char>? '(#\e #\u #\i)) #\u)
(check-equal? (busca-mayor string>? '("hola" "adios")) "hola")
(check-equal? (busca-mayor (lambda (x y)
                             (> (string-length x)
                                (string-length y)))
                           '("hola" "adios")) "adios")


;;Practica 5


;;concat con recursion por cola
(define(concat lista)
  (concat-iter lista ""))

(define (concat-iter lista res)
  (if(null? lista) res
  (concat-iter (cdr lista)(string-append res (car lista)))))



;;(concat  '("hola" "y" "adiós")) ; ⇒ "holayadiós")
;;(concat-iter '("hola" "y" "adiós") "") ; ⇒ "holayadiós")


(define (min-max lista)
  (if (null? lista) (cons 0 0)
  (min-max-iter lista (cons(car lista) (car lista)))))

(define (min-max-iter lista res)
  (cond((null? lista) res)
       ((<(car lista) (car res)) (min-max-iter (cdr lista) (cons (car lista) (cdr res))))
       ((>(car lista) (cdr res)) (min-max-iter (cdr lista) (cons (car res) (car lista))))
       (else (min-max-iter (cdr lista) res))))
;;(min-max '(2 5 9 12 5 0 4))

(define (rotar veces lista)
  (if(= veces 0) lista
     (rotar (- veces 1) (append (cdr lista) (list (car lista))))))

;(rotar 4 '(a b c d e f g)) ; ⇒ (e f g a b c d)


(define (prefijo-lista? prefijo lista)
  (if(null? prefijo) #t
     (if(equal? (car prefijo) (car lista)) (and (prefijo-lista? (cdr prefijo) (cdr lista))) #f)))



;(prefijo-lista? '(a b) '(a b c d e))
;(prefijo-lista? '(b c) '(a b c d e)) 

;;Tortuga

(define (koch n trazo)
  (if (= 0 n)
      (draw trazo)
      (begin
        (koch (- n 1) (/ trazo 3))
        (turn 60)
        (koch (- n 1) (/ trazo 3))
        (turn -120)
        (koch (- n 1) (/ trazo 3))
        (turn 60)
        (koch (- n 1) (/ trazo 3))
        )))

(define (koch-ventana nivel trazo)
  (turtles #t)
  (clear)
  (turn 180)
  (move (/ trazo 2))
  (turn 180)
  (koch nivel trazo))






(define (copo-nieve nivel trazo)
  (begin
    (koch nivel trazo)
    (turn -120)
    (koch nivel trazo)
    (turn -120)
    (koch nivel trazo)))

(define (copo-nieve-ventana nivel trazo)
  (turtles #t)
  (clear)
  (turn 120)
  (move (/ trazo 3))
  (turn 60)
  (move (/ trazo 3))
  (turn 180)
  (copo-nieve nivel trazo))

;;(copo-nieve-ventana 1 200)



;;Practica 6

;;Ejer 1

(define lista-a '((a b) d (c (e) (f g) h)))

(check-equal? (car (caddr (caddr lista-a))) 'f)
(check-equal? (cadddr (caddr lista-a)) 'h)

;; BARRERA DE ABSTRACCION
(define (dato-arbol arbol) 
    (car arbol))

(define (hijos-arbol arbol) 
    (cdr arbol))

(define (hoja-arbol? arbol) 
   (null? (hijos-arbol arbol)))

(define (construye-arbol dato lista-arboles)
   (cons dato lista-arboles))

(define (hoja? elem)
   (not (list? elem)))

(define arbol1 '(30 (15 (10) (12)) (18) (25 (19) (21) (22))))

(define lista-b1 '((2 (3)) (4 2) ((2) 3)))
(define lista-b2 '((b) (c (a)) d (a)))

(define (cuadrado-estruct lista)
  (cond ((null? lista) '())
        ((hoja? lista) (* lista lista ))
        (else (cons (cuadrado-estruct (car lista))
                    (cuadrado-estruct (cdr lista))))))

;;(cuadrado-estruct lista-b1)



(define (cuenta-pares lista)
  (cond ((null? lista) 0)
        ((hoja? lista)(if (even? lista) 1 0))
        (else (+ (cuenta-pares (car lista)) (cuenta-pares (cdr lista))))
      ))

(check-equal? (cuenta-pares '(1 (2 3) 4 (5 6))) 3)
(check-equal? (cuenta-pares '(((1 2) 3 (4) 5) ((((6)))))) 3)

(define (cuenta-pares-fos elem)
  (if(hoja? elem)
     (if(even? elem) 1 0)
     (foldr + 0 (map cuenta-pares-fos elem))))

(check-equal? (cuenta-pares-fos '(1 (2 3) 4 (5 6))) 3)
(check-equal? (cuenta-pares-fos '(((1 2) 3 (4) 5) ((((6)))))) 3)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (todos-positivos-fos lista)
  (cond ((null? lista) #t)
        ((hoja? lista) (positive? lista))
        (else (andmap todos-positivos lista))
        ))

(define (todos-positivos lista)
  (cond ((null? lista) #t)
        ((hoja? lista) (positive? lista))
        (else (and (todos-positivos (car lista))(todos-positivos (cdr lista))))))
(check-equal? (todos-positivos '(1 (2 (3 (-3))) 4)) #f) ; ⇒ #f

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (mezclar lista1 lista2 n)
  (cond ((null? lista1) '())
        ((hoja? lista1) (if (< n 0) lista2 lista1))
        (else (cons (mezclar (car lista1) (car lista2) (- n 1))
                    (mezclar (cdr lista1) (cdr lista2) n)))))

(define (nivel-elemento lista)
  (cond ((null? lista) (cons 0 0))
        ((hoja? lista) (cons lista 0))
        (else (lambda (p1 p2)
                (if (>(cdr p1) (cdr p2)) p1 p2))(nivel-elemento (car lista))(nivel-elemento (cdr lista)))))

;;NO ACABADO
;;(nivel-elemento '(2 (3))) ; ⇒ (3 . 2)


;;ARBOLES (GENERICOS)

(define arbol '(15 (4 (2) (3)) (8 (6)) (12 (9) (10) (11))))
(check-equal? (dato-arbol (cadr (hijos-arbol (caddr (hijos-arbol arbol))))) 10)

(define (suma-datos-arbol arbol)
    (+ (dato-arbol arbol)
       (suma-datos-bosque (hijos-arbol arbol))))

(define (suma-datos-bosque bosque)
    (if (null? bosque)
        0
        (+ (suma-datos-arbol (car bosque)) 
           (suma-datos-bosque (cdr bosque)))))



(define (suma-datos-arbol-fos arbol)
   (foldr + (dato-arbol arbol) 
       (map suma-datos-arbol-fos (hijos-arbol arbol))))
;;(suma-datos-arbol-fos arbol)



(define (to-string-bosque bosque)
  (if(null? bosque) ""
     (string-append (to-string-arbol (car bosque))
                     (to-string-bosque (cdr bosque)))))

(define (to-string-arbol arbol)
  (string-append(symbol->string (dato-arbol arbol))
                (to-string-bosque (hijos-arbol arbol))))

(define arbol2 '(a (b (c (d)) (e)) (f)))
(to-string-arbol arbol2) ; ⇒ "abcdef"

(define arbolq '(a(b (c (e)) (d)) (f (g (m) (n))) (h (i) (j) (k))))

(define (hijos-hoja? arbol)
  (cond ((null? arbol) #f)
        ((hoja? arbol) #f)
        ((null? (hijos-arbol arbol)) #f)
        (else(andmap hoja? (dato-arbol (hijos-arbol arbol))))))

(check-false (hijos-hoja? arbolq))
(check-false (hijos-hoja? (cadr (hijos-arbol arbolq))))
(check-true (hijos-hoja? (caddr (hijos-arbol arbolq))))

;;ARBLOES BINARIOS

;;BARRERA DE ABSTRACCION BINARIO
(define (dato-arbolb arbol)
   (car arbol))

(define (hijo-izq-arbolb arbol)
   (cadr arbol))

(define (hijo-der-arbolb arbol)
   (caddr arbol))

(define arbolb-vacio '())

(define (vacio-arbolb? arbol)
   (equal? arbol arbolb-vacio))

(define (hoja-arbolb? arbol)
   (and (vacio-arbolb? (hijo-izq-arbolb arbol))
        (vacio-arbolb? (hijo-der-arbolb arbol))))

(define arbolb '(40 (23 (5 () ()) (32 (29) (80))) (45 () (56 () ()))))
;;(dato-arbolb (hijo-der-arbolb (hijo-der-arbolb (hijo-izq-arbolb arbolb))))










