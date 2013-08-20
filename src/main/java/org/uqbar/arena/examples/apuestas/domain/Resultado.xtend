package org.uqbar.arena.examples.apuestas.domain

import java.math.BigDecimal

abstract class Resultado {
	@Property int ganador

	new(int ganador) {
		this.ganador = ganador
	}

}

class Ganador extends Resultado {
	BigDecimal montoGanado

	new(int ganador, BigDecimal montoGanado) {
		super(ganador)
		this.montoGanado = montoGanado
	}

	override toString() {
		'''Gana «montoGanado»'''
	}
}

class Perdedor extends Resultado {
	new(int ganador) {
		super(ganador)
	}

	override toString() {
		'''Perdiste, salió el «ganador»'''
	}
}
