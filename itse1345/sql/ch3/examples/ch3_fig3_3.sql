--FIGURE 3-3 A SELECT statement
DECLARE 
  lv_qty_num NUMBER(3);
BEGIN
  SELECT SUM(quantity)
    INTO lv_qty_num
    FROM bb_basketitem
    WHERE idBasket = 15;
  DBMS_OUTPUT.PUT_LINE(lv_qty_num);
END;