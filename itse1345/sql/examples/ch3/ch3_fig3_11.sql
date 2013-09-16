--FIGURE 3-11 Retrieving state data to determine the tax amount

DECLARE
  lv_shipstate bb_basket.shipstate%TYPE;
  lv_subtotal bb_basket.subtotal%TYPE;
  lv_tax_num NUMBER(4,2) := 0;
BEGIN
  SELECT subtotal, shipstate
    INTO lv_subtotal, lv_shipstate
    FROM bb_basket
    WHERE idbasket = 6;
  IF lv_shipstate = 'VA' THEN 
    lv_tax_num := lv_subtotal * 0.06;
  END IF;
  DBMS_OUTPUT.PUT_LINE('State: ' || lv_shipstate || ' Subtotal: ' || lv_subtotal || ' Tax: ' || lv_tax_num);
  END;