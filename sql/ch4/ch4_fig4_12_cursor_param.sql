/*
	Figure 4-12 Using a cursor parameter
	Parameters are values passed to the cursor when it's opened and used in the 
	cursor's SELECT statement to determine what data the cursor contains.
*/
DECLARE
	lv_bask1_num bb_basket.idbasket%TYPE := 6;
	lv_bask2_num bb_basket.idbasket%TYPE := 10;
	CURSOR cur_order (p_basket NUMBER) IS
		SELECT idbasket, idproduct, price, quantity
			FROM bb_basketitem
			WHERE idbasket = p_basket;
BEGIN
	FOR rec_order IN cur_order(lv_bask1_num) LOOP
		DBMS_OUTPUT.PUT_LINE(rec_order.idbasket || '  - ' ||
			rec_order.idproduct || '  - ' || rec_order.price);
	END LOOP;
	FOR rec_order IN cur_order(lv_bask2_num) LOOP
		DBMS_OUTPUT.PUT_LINE(rec_order.idbasket || ' - ' ||
			rec_order.idproduct || '  - ' || rec_order.price);
	END LOOP;
END;