--FIGURE 3-5 A block for checking an uncompleted basket

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