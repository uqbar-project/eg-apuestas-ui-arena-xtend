package ar.edu.apuestas

import org.uqbar.arena.Application

class ApuestasApplication extends Application {
	
	override createMainWindow() {
		new CrearApuestaWindow(this, new Apuesta)
	}
	
	def static main(String[] args) {
		new ApuestasApplication().start
	}
}
