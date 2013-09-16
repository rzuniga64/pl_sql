--FIGURE 3-19 Declaring a record variable
DECLARE
  TYPE type_basket IS RECORD(
    basket bb_basket.idbasket%TYPE,
    created bb_basket.dtcreated%TYPE,
    qty bb_basket.quantity%TYPE,
    sub bb_basket.subtotal%TYPE);
  rec_basket type_basket;
  lv_days_num NUMBER(3);
  lv_shopper_num NUMBER(3) := 25;
BEGIN
  SELECT idbasket, dtcreated, quantity, subtotal
  INTO rec_basket
  FROM bb_basket
  WHERE idshopper = lv_shopper_num AND orderplaced = 0;
  lv_days_num := SYSDATE - rec_basket.created;
  dbms_output.put_line(rec_basket.basket || '*' || rec_basket.created || '*' || rec_basket.qty || '*' || rec_basket.sub || '*' || lv_days_num);
END; 