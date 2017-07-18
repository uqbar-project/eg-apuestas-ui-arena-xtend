package ar.edu.apuestas

import java.math.BigDecimal
import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException

class BigDecimalTransformer implements ValueTransformer<BigDecimal, String> {

	override getModelType() {
		BigDecimal
	}

	override getViewType() {
		String
	}

	override modelToView(BigDecimal valueFromModel) {
		valueFromModel.toString
	}

	override viewToModel(String valueFromView) {
		if (valueFromView == "")
			null
		else
			try
				new BigDecimal(valueFromView)
			catch (NumberFormatException e)
				throw new UserException("El valor ingresado debe ser un número", e)

	}
}
