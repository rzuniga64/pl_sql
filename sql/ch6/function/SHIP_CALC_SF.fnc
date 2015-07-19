CREATE OR REPLACE FUNCTION ship_calc_sf
	(p_qty IN NUMBER)
RETURN NUMBER
IS
	lv_ship_num NUMBER(5,2);
BEGIN
	IF p_qty > 10 THEN
		lv_ship_num := 11.00;
	ELSIF p_qty > 5 THEN
		lv_ship_num := 8.00;
	ELSE
		lv_ship_num := 5.00;
	END IF; 
	RETURN lv_ship_num;
END;
/