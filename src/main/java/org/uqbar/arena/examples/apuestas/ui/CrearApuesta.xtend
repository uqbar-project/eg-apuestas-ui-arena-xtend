package org.uqbar.arena.examples.apuestas.ui

import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.examples.apuestas.domain.Apuesta
import org.uqbar.arena.examples.apuestas.domain.ApuestaDocena
import org.uqbar.arena.examples.apuestas.domain.ApuestaPleno
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.MainWindow
import org.uqbar.commons.utils.Observable

@Observable
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

		new Button(mainPanel).setAsDefault.setCaption("Jugar").bindEnabledToProperty("sePuedeJugar")
	}

	def createEditorPanel(Panel editorPanel) {
		editorPanel.setLayout(new ColumnLayout(2))

		new Label(editorPanel).setText("Fecha")
		new TextBox(editorPanel).bindValueToProperty("fecha")

		new Label(editorPanel).setText("Monto")
		new TextBox(editorPanel).bindValueToProperty("monto").setTransformer(new BigDecimalTransformer)

		new Label(editorPanel).setText("Tipo de Apuesta")
		val selectorTipo = new Selector(editorPanel).allowNull(false)
		selectorTipo.bindItems(new ObservableProperty(this, "tiposPosibles"))
		selectorTipo.bindValueToProperty("tipo")

		new Label(editorPanel).setText("¿Qué querés apostar?")
		selectorTipo.bindItemsToProperty("tipo.valoresPosibles")
		selectorTipo.bindValueToProperty("valorApostado")
	}

	def getTiposPosibles() {
		#[new ApuestaPleno, new ApuestaDocena]
	}

	def static main(String[] args) {
		new CrearApuesta(new Apuesta).startApplication
	}
}
