--FIGURE 3-12 Including data retrieval and conditional IF processing in a block
DECLARE
  lv_shipstate bb_basket.shipstate%TYPE;
  lv_subtotal bb_basket.subtotal%TYPE;
  lv_tax_num NUMBER(4,2) := 0;
BEGIN
  SELECT subtotal, shipstate
  INTO lv_subtotal, lv_shipstate
  FROM bb_basket
  WHERE idbasket = 4;

  IF lv_shipstate = 'VA' THEN
    lv_tax_num := lv_subtotal * 0.06;
  ELSIF lv_shipstate = 'ME' THEN
    lv_tax_num := lv_subtotal * 0.05;
  ELSIF lv_shipstate = 'NY' THEN
    lv_tax_num := lv_subtotal * 0.07;
  ELSE 
    lv_tax_num := lv_subtotal * 0.04;
  END IF;
  DBMS_OUTPUT.PUT_LINE('State: ' || lv_shipstate || ' Subtotal: ' || lv_subtotal || ' Tax: ' || lv_tax_num);
  END;