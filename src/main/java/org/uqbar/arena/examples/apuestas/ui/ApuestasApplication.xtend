package org.uqbar.arena.examples.apuestas.ui

import org.uqbar.arena.Application
import org.uqbar.arena.examples.apuestas.domain.Apuesta

class ApuestasApplication extends Application {
	
	override createMainWindow() {
		new CrearApuestaWindow(this, new Apuesta)
	}
	
	def static main(String[] args) {
		new ApuestasApplication().start
	}
}
