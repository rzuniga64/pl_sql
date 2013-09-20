/*
	An example of using %TYPE attribute
	
	When creating variables to hold database column values.,
	the %TYPE attribute can be used in the variable declaration
	to provide the data type.  It tells the system to look up a
	database column's data type and use if for the declared
	variable.  Specifying a data type this way is called using
	an anchored data type.
*/
DECLARE
  lv_created_date bb_basket.dtcreated%TYPE;
  lv_idbasket bb_basket.idbasket%TYPE;
  lv_quantity bb_basket.quantity%TYPE;
  lv_subtotal bb_basket.subtotal%TYPE;
  lv_days_num NUMBER(3);
  lv_shopper_num NUMBER(3) := 25;
BEGIN
  SELECT idbasket, dtcreated, quantity, subtotal
  INTO lv_idbasket, lv_created_date, lv_quantity, lv_subtotal
  FROM bb_basket
  WHERE idshopper = lv_shopper_num AND orderplaced = 0;
  lv_days_num := SYSDATE - lv_created_date;
  DBMS_OUTPUT.PUT_LINE(lv_idbasket || ' * ' || lv_created_date || ' * ' || lv_quantity || ' * ' || lv_subtotal || ' * ' || lv_days_num);
END;