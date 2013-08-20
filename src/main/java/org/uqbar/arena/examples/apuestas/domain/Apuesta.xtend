package org.uqbar.arena.examples.apuestas.domain

import java.math.BigDecimal
import java.util.Date
import java.util.Random
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

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

	def void setMonto(BigDecimal monto) {
		if (monto <= new BigDecimal(0)) throw new UserException("El monto debe ser positivo.")
		this._monto = monto
	}

	def jugar() {
		tipo.validarMontoMinimo(monto)
		
		val ganador = new Random().nextInt(37)
		resultado = tipo.chequearApuesta(ganador, this)
	}
}

