package org.uqbar.arena.examples.apuestas.ui

import org.eclipse.swt.SWT
import org.uqbar.arena.bindings.NotNullObservable
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
		new TextBox(editorPanel).bindValueToProperty("fecha")

		new Label(editorPanel).setText("Monto")
		new TextBox(editorPanel).bindValueToProperty("monto").setTransformer(new BigDecimalTransformer)

		new Label(editorPanel).setText("Tipo de Apuesta")
		val selectorTipo = new Selector(editorPanel).allowNull(false)
		selectorTipo.bindItems(new ObservableProperty(this, "tiposPosibles"))
		selectorTipo.bindValueToProperty("tipo")

		new Label(editorPanel).setText("¿Qué querés apostar?")
		val selectorApuesta = new Selector(editorPanel).allowNull(false)
		selectorApuesta.setWidth(100)
		selectorApuesta.bindItemsToProperty("tipo.valoresPosibles")
		selectorApuesta.bindValueToProperty("valorApostado")
	}

	override addActions(Panel actionsPanel) {
		val botonJugar = new Button(actionsPanel).setAsDefault.setCaption("Jugar")
		botonJugar.onClick[|modelObject.jugar]
		botonJugar.bindEnabled(new NotNullObservable("valorApostado"))
		
		val labelResultado = new Label(actionsPanel)
		labelResultado.setWidth(150)
		labelResultado.bindValueToProperty("resultado")
	}

	def getTiposPosibles() {
		#[new ApuestaPleno, new ApuestaDocena]
	}

	// ************************************************************************
	// ** Hacks
	// ************************************************************************
	override showInfo(String message) {
		this.showMessageBox(message, SWT.OK.bitwiseOr(SWT.ICON_INFORMATION))
	}

	override showWarning(String message) {
		this.showMessageBox(message, SWT.OK.bitwiseOr(SWT.ICON_WARNING))
	}

	override showError(String message) {
		this.showMessageBox(message, SWT.OK.bitwiseOr(SWT.ICON_ERROR))
	}

}
