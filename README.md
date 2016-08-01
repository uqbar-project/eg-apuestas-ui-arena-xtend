# Apuestas

![ruleta](https://cloud.githubusercontent.com/assets/4549002/17299651/9dcb3e56-57e5-11e6-83d3-4a43e6cb4dc8.png)

# Enunciado

Se pide diseñar una UI para modelar una apuesta de una ruleta virtual que tenga la siguiente información:

* Fecha en la que se hace la apuesta
* Monto a apostar (un número)
* Tipo de apuesta
 * a pleno: se puede apostar un número de 1 al 36
 * docena: se apuesta primera, segunda o tercera docena.

Las reglas de validación de una apuesta son:

* se debe apostar un número positivo, pero además
 * el monto mínimo de una apuesta a pleno son $ 10, para una apuesta a docena son $ 50
* la fecha a apostar debe ser el día de hoy o una fecha futura (válida, claro está)
* se debe indicar tipo de apuesta (en el caso del pleno, el número; en el caso de la docena, qué docena)

Una vez apostado, el jugador espera el resultado de la apuesta:

* de la ruleta sale un número del 0 al 36
* el premio por ganar una apuesta a pleno es 35 veces el valor de la apuesta, mientras que es 11 veces para una apuesta a docena
* el sistema debe informar si el apostador ganó o perdió. En el primer caso debe quedar claro el monto ganado, en el segundo el número que salió.

# La aplicación

![image](https://cloud.githubusercontent.com/assets/4549002/17304378/bd559b52-57fb-11e6-8fc2-4515548ca6a7.png)

* Tiene una vista con un combo anidado entre el tipo de apuesta y el valor apostado. 
* El modelo es un objeto Apuesta con un strategy por el tipo de apuesta. 
* Cada estrategia de apuesta construye un resultado por ganador/perdedor que se bindea contra un label que muestra cómo le fue al usuario
* Hay diferentes momentos para validar cosas
 * el botón apostar se habilita cuando se supera el monto mínimo de la apuesta, hay un valor apostado y la fecha para apostar es posterior a la fecha del día
 * si ingresás una fecha inválida, te avisa en el panel de errores (arriba del formulario)
 * pero además, hay un DateTextFilter que impide al usuario ingresar valores incorrectos al cargar la fecha (ej: no se puede ingresar la barra / como primer caracter, solo en la tercera o sexta posición)
 
