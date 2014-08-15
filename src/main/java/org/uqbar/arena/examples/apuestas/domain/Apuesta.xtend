package org.uqbar.arena.examples.apuestas.domain

import java.math.BigDecimal
import java.util.Date
import java.util.Random
import org.uqbar.commons.model.ObservableUtils
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
		fecha != null && fecha.after(hoy) 
		&& monto != null && monto > BigDecimal.ZERO
		&& tipo != null
		&& valorApostado != null
	}

	def void setFecha(Date fecha) {
		this._fecha = fecha
		cambioPuedeApostar
	}
	
	def void setTipo(TipoApuesta tipo) {
		this._tipo = tipo
		cambioPuedeApostar
	}
	
	def void setValorApostado(Object valor) {
		this._valorApostado = valor
		cambioPuedeApostar
	}
	
	def cambioPuedeApostar() {
		ObservableUtils.firePropertyChanged(this, "puedeJugar", puedeJugar)
	}

	def void setMonto(BigDecimal monto) {
		if (monto == null || monto <= BigDecimal.ZERO) 
			throw new UserException("El monto debe ser positivo.")

		this._monto = monto
		cambioPuedeApostar
	}

	def jugar() {
		tipo.validarMontoMinimo(monto)

		val ganador = new Random().nextInt(37)
		resultado = tipo.chequearApuesta(ganador, this)
	}
}
