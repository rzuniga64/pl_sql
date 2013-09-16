-- FIGURE 3-13 Including data retieval and conditional CASE processing in a block
DECLARE
  lv_shipstate bb_basket.shipstate%TYPE;
  lv_subtotal bb_basket.subtotal%TYPE;
  lv_tax_num NUMBER(4,2) := 0;
BEGIN
  SELECT subtotal, shipstate
  INTO lv_subtotal, lv_shipstate
  FROM bb_basket
  WHERE idbasket = 4;

  CASE lv_shipstate
    WHEN 'VA' THEN lv_tax_num := lv_subtotal * 0.06;
    WHEN 'ME' THEN lv_tax_num := lv_subtotal * 0.05;
    WHEN 'NY' THEN lv_tax_num := lv_subtotal * 0.07;
    ELSE lv_tax_num := lv_subtotal * 0.04;
  END CASE;
  DBMS_OUTPUT.PUT_LINE('State: ' || lv_shipstate || ' Subtotal: ' || lv_subtotal || ' Tax: ' || lv_tax_num);
  END;