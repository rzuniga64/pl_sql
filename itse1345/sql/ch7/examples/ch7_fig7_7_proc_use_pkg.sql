DECLARE
	lv_ship_num NUMBER(8,2);
BEGIN
	lv_ship_num := ordering_pkg.ship_calc_pf(7);
	DBMS_OUTPUT.PUT_LINE('Shipping cost: ' || lv_ship_num);
END;