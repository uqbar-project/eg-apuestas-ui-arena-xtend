package org.uqbar.arena.examples.apuestas.ui

import org.uqbar.arena.Application
import org.uqbar.arena.examples.apuestas.domain.Apuesta

class ApuestasApplication extends Application {
	override createMainWindow() {
		new CrearApuesta(this, new Apuesta)
	}
	
	static def main(String[] args) {
		new ApuestasApplication().start
	}
}
