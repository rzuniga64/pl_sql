/*
	Figure 4-14 The 'no data found' error is raised
*/
DECLARE
	TYPE type_basket IS RECORD
		(basket bb_basket.idbasket%TYPE,
		created bb_basket.dtcreated%TYPE,
		qty bb_basket.quantity%TYPE,
		sub bb_basket.subtotal%TYPE);
	rec_basket type_basket;
	lv_days_num NUMBER(3);
	lv_shopper_num NUMBER(3) := 22;
BEGIN
	SELECT idbasket, dtcreated, quantity, subtotal
		INTO rec_basket
		FROM bb_basket
		WHERE idshopper = lv_shopper_num
		AND orderplaced = 0;
	lv_days_num := TO_DATE('02/28/12', 'mm/dd/yy') - rec_basket.created;
	DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
	DBMS_OUTPUT.PUT_LINE(rec_basket.created);
	DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
	DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
	DBMS_OUTPUT.PUT_LINE(lv_days_num);
END;				
	