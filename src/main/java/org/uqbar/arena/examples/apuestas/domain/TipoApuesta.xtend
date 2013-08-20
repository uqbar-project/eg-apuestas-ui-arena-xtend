package org.uqbar.arena.examples.apuestas.domain

import java.math.BigDecimal
import java.util.List
import org.uqbar.commons.model.UserException

abstract class TipoApuesta {
	override toString() {
		this.class.simpleName.substring(7)
	}

	def List<Object> getValoresPosibles()

	def validarMontoMinimo(BigDecimal monto) {
		if (monto < new BigDecimal(montoMinimo)) {
			throw new UserException('''El monto minimo para una apuesta «this» es «montoMinimo»''')
		}
	}

	def int montoMinimo()

	def asObjects(List<?> list) {
		list.map[it as Object]
	}
}

class ApuestaPleno extends TipoApuesta {
	override getValoresPosibles() {
		(1 .. 36).toList.asObjects
	}

	override montoMinimo() {
		10
	}
}

class ApuestaDocena extends TipoApuesta {
	val docenas = #["Primera", "Segunda", "Tercera"]

	override getValoresPosibles() {
		docenas.asObjects
	}

	override montoMinimo() {
		50
	}
}
