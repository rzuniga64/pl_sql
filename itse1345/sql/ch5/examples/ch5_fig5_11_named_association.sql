DECLARE
	lv_ship_num NUMBER(6,2);
BEGIN
	SHIP_COST_SP(p_ship => lv_ship_num, p_qty => 7 );
	DBMS_OUTPUT.PUT_LINE('Ship Cost = ' || lv_ship_num);
END;