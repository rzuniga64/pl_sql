SELECT idbasket, quantity, shipping actual, 
		ship_calc_sf(quantity) calc,
		ship_calc_sf(quantity) - shipping diff
FROM bb_basket
WHERE orderplaced = 1;