package org.uqbar.arena.examples.apuestas.ui

import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.examples.apuestas.domain.Apuesta
import org.uqbar.arena.examples.apuestas.domain.ApuestaDocena
import org.uqbar.arena.examples.apuestas.domain.ApuestaPleno
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.utils.Observable

@Observable
class CrearApuesta extends SimpleWindow<Apuesta> {
	new(WindowOwner owner, Apuesta apuesta) {
		super(owner, apuesta)
		title = "Ruleta"
		taskDescription = "Hagan sus apuestas!!!"
	}

	override createFormPanel(Panel mainPanel) {
		val editorPanel = new Panel(mainPanel)
		editorPanel.setLayout(new ColumnLayout(2))

		new Label(editorPanel).setText("Fecha")
		val textBoxFecha = new DateBox(editorPanel)
		textBoxFecha.bindValueToProperty("fecha")

		new Label(editorPanel).setText("Monto")
		val textBoxMonto = new TextBox(editorPanel)
		val bindingMonto = textBoxMonto.bindValueToProperty("monto")
		bindingMonto.transformer = new BigDecimalTransformer

		new Label(editorPanel).setText("Tipo de Apuesta")
		val selectorTipo = new Selector(editorPanel).allowNull(false)
		selectorTipo.bindItems(new ObservableProperty(this, "tiposPosibles"))

		selectorTipo.bindValueToProperty("tipo")

		new Label(editorPanel).setText("¿A qué querés apostar?")
		val selectorApuesta = new Selector(editorPanel).allowNull(false)
		selectorApuesta.setWidth(100)
		selectorApuesta.bindItemsToProperty("tipo.valoresPosibles")
		selectorApuesta.bindValueToProperty("valorApostado")
	}

	override addActions(Panel actionsPanel) {
		new Button(actionsPanel)
			.setCaption("Jugar")
			.setAsDefault
			.onClick[ |jugar]
			.disableOnError
			.bindEnabledToProperty("puedeJugar")

		new Label(actionsPanel)
			.setWidth(150)
			.bindValueToProperty("resultado")
		
		new Button(actionsPanel)
			.setCaption("Numeros Ganadores")
			.onClick[ |verNumerosGanadores]
	}

	def jugar() {
		modelObject.jugar
		showInfo(modelObject.resultado.toString)
	}

	def verNumerosGanadores(){
		
	}

	def getTiposPosibles() {
		#[new ApuestaPleno, new ApuestaDocena]
	}
}

class DateBox extends TextBox {
	new(Panel container) {
		super(container)
	}

	override bindValueToProperty(String propertyName) {
		val binding = super.bindValueToProperty(propertyName)
		this.withFilter(new DateTextFilter)
		binding
	}
}

