SELECT SUM(quantity) qty, SUM(quantity * price) subtotal,
		SUM(quantity * price) - (SUM(quantity * price) * 0.05) "new_subtotal"
		FROM bb_basketitem
		WHERE idbasket = 12;