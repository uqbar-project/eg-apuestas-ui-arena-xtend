package org.uqbar.arena.examples.apuestas.domain

abstract class TipoApuesta {
	override toString() {
		this.class.simpleName
	}
}

class ApuestaPleno extends TipoApuesta {
}

class ApuestaDocena extends TipoApuesta {
}
