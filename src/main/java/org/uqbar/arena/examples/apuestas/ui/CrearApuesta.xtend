package org.uqbar.arena.examples.apuestas.ui

import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.examples.apuestas.domain.Apuesta
import org.uqbar.arena.examples.apuestas.domain.ApuestaDocena
import org.uqbar.arena.examples.apuestas.domain.ApuestaPleno
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.MainWindow

class CrearApuesta extends MainWindow<Apuesta> {
	new(Apuesta apuesta) {
		super(apuesta)
	}

	override createContents(Panel mainPanel) {
		setTitle("Creación de apuestas")

		mainPanel.setLayout(new VerticalLayout)
		new ErrorsPanel(mainPanel, "Ingrese los datos de su apuesta")

		val editorPanel = new Panel(mainPanel)
		createEditorPanel(editorPanel)
	}

	def createEditorPanel(Panel editorPanel) {
		editorPanel.setLayout(new ColumnLayout(2))

		new Label(editorPanel).setText("Fecha")
		new TextBox(editorPanel).bindValueToProperty("fecha")

		new Label(editorPanel).setText("Monto")
		new TextBox(editorPanel).bindValueToProperty("monto")

		new Label(editorPanel).setText("Tipo de Apuesta")
		val tipoSelector = new Selector(editorPanel)
		tipoSelector.bindValueToProperty("tipo")
		tipoSelector.bindItems(new ObservableProperty(this, "tiposPosibles"))
	}

	def getTiposPosibles() {
		#[new ApuestaPleno, new ApuestaDocena]
	}

	def static main(String[] args) {
		new CrearApuesta(new Apuesta).startApplication
	}
}
