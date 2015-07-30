/*
	Code displaying an exception handler message to users
	The block traps the 'no data found' erorrs and displays 
	a message on onscreen.  change the lv_shopper_num variable
	to value 26. The block traps the 'too many rows' error and 
	displays a message onscreen.
*/
DECLARE 
 TYPE type_basket IS RECORD (
   basket bb_basket.idBasket%TYPE,
   created bb_basket.dtcreated%TYPE,
   qty bb_basket.quantity%TYPE,
   sub bb_basket.subtotal%TYPE);
 rec_basket type_basket;
 lv_days_num NUMBER(3);
 lv_shopper_num NUMBER(3) := 0;	
BEGIN
 SELECT idBasket, dtcreated, quantity, subtotal
  INTO rec_basket
  FROM bb_basket
  WHERE idShopper = lv_shopper_num 
    AND orderplaced = 0;
 lv_days_num := TO_DATE('02/28/12','mm/dd/yy') - rec_basket.created;
 DBMS_OUTPUT.PUT_LINE(rec_basket.basket);
 DBMS_OUTPUT.PUT_LINE(rec_basket.created);
 DBMS_OUTPUT.PUT_LINE(rec_basket.qty);
 DBMS_OUTPUT.PUT_LINE(rec_basket.sub);
 DBMS_OUTPUT.PUT_LINE(lv_days_num);
EXCEPTION
	WHEN NO_DATA_FOUND THEN
   	DBMS_OUTPUT.PUT_LINE('You have no saved baskets!');
  	WHEN TOO_MANY_ROWS THEN
   	DBMS_OUTPUT.PUT_LINE('A problem has ocurred in retrieving your saved basket.');
   	DBMS_OUTPUT.PUT_LINE('Tech Support will be notified and contact you via email.'); 
END;				
	