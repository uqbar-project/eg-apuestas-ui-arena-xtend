package org.uqbar.arena.examples.apuestas.domain

import java.math.BigDecimal
import java.util.Date
import org.uqbar.commons.utils.Observable

@Observable
class Apuesta {
	@Property Date fecha
	@Property BigDecimal monto
	@Property TipoApuesta tipo
}

