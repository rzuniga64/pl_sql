/*
  Figure 4-22 Checking the quantity of stock on hand
*/

DECLARE
  lv_ordqty_num NUMBER(2) := 20;
  lv_stock_num bb_product.stock%TYPE;
  ex_prod_stk EXCEPTION;
BEGIN
  SELECT stock
    INTO lv_stock_num
    FROM bb_product
    WHERE idproduct = 2;
  IF lv_ordqty_num > lv_stock_num THEN
    RAISE ex_prod_stk;
  END IF;
EXCEPTION
  WHEN ex_prod_stk THEN 
    DBMS_OUTPUT.PUT_LINE('Required quantity beyond stock level');
    DBMS_OUTPUT.PUT_LINE('Req qty = ' || lv_ordqty_num || 
                          ' Stock qty = ' || lv_stock_num);
END;