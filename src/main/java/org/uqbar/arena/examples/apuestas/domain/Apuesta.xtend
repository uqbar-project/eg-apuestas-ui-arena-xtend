package org.uqbar.arena.examples.apuestas.domain

import java.math.BigDecimal
import java.util.Date
import org.uqbar.commons.utils.Observable
import java.util.Random

@Observable
class Apuesta {
	@Property Date fecha
	@Property BigDecimal monto
	@Property TipoApuesta tipo
	@Property Object valorApostado
	@Property Resultado resultado

	val hoy = new Date()

	def isPuedeJugar() {
		fecha != null && fecha.after(hoy) && monto != null && monto > new BigDecimal(0)
	}

	def jugar() {
		tipo.validarMontoMinimo(monto)
		
		val ganador = new Random().nextInt(37)
		resultado = tipo.chequearApuesta(ganador, this)
	}
}

