package org.uqbar.arena.examples.apuestas.ui

import org.uqbar.arena.bindings.DateAdapter
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

/**
 * 
 */
@Observable
class CrearApuestaWindow extends SimpleWindow<Apuesta> {
	
	new(WindowOwner owner, Apuesta apuesta) {
		super(owner, apuesta)
		title = "Ruleta"
		taskDescription = "Hagan sus apuestas!!!"
	}

	override createFormPanel(Panel mainPanel) {
		val editorPanel = new Panel(mainPanel)
		editorPanel.setLayout(new ColumnLayout(2))
		
		new Label(editorPanel).setText("Fecha")
		
		val textBoxFecha = new TextBox(editorPanel)
		textBoxFecha.withFilter(new DateTextFilter)
		
		val binding = textBoxFecha.bindValueToProperty("fecha")
		binding.setTransformer(new DateAdapter)
		
		
		new Label(editorPanel).setText("Monto")
		
		new TextBox(editorPanel) => [
			val bindingMonto = bindValueToProperty("monto")
			bindingMonto.transformer = new BigDecimalTransformer			
		]

		new Label(editorPanel).setText("Tipo de Apuesta")
		new Selector(editorPanel) => [
			allowNull = false
			bindItems(new ObservableProperty(this, "tiposPosibles"))
			bindValueToProperty("tipo")
//			bindValue(new ObservableProperty(this.modelObject, "tipo"))
		]

		new Label(editorPanel).setText("¿A qué querés apostar?")
		new Selector(editorPanel) => [
			allowNull = false
			width = 100
			bindItemsToProperty("tipo.valoresPosibles")
			bindValueToProperty("valorApostado")			
		]
	}

	override addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Jugar"
			setAsDefault
			onClick[|
				jugar
			]
	
			// bindEnabled(new NotNullObservable("valorApostado"))
			bindEnabledToProperty("puedeJugar")
			disableOnError
		]

		new Label(actionsPanel) => [
			width = 150
			bindValueToProperty("resultado")
		]
	}

	def jugar() {
		modelObject.jugar
		showInfo(modelObject.resultado.toString)
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

