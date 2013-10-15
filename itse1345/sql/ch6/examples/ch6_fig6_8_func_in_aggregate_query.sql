SELECT  SUM(shipping) actual,
		SUM(ship_calc_sf(quantity)) calc,
		SUM(ship_calc_sf(quantity) - shipping) diff
	FROM bb_basket
	WHERE orderplaced = 1;