--FIGURE 3-14 Performing an INSERT in a block
DECLARE 
  lv_firstname bb_shopper.firstname%TYPE := 'Jeffrey';
  lv_lastname bb_shopper.lastname%TYPE := 'Brand';
  lv_email bb_shopper.email%TYPE := 'jbrand@site.com';
BEGIN
  INSERT INTO bb_shopper(idshopper, firstname, lastname, email)
    VALUES (bb_shopper_seq.NEXTVAL, lv_firstname, lv_lastname, lv_email);
  COMMIT;
END;

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
    WHEN 'VA' THEN 
      lv_tax_num := lv_subtotal * 0.06;
    WHEN 'ME' THEN
      lv_tax_num := lv_subtotal * 0.05;
    WHEN 'NY' THEN
      lv_tax_num := lv_subtotal * 0.07;
    ELSE 
      lv_tax_num := lv_subtotal * 0.04;
  END CASE;
  DBMS_OUTPUT.PUT_LINE('State: ' || lv_shipstate || ' Subtotal: ' || lv_subtotal || ' Tax: ' || lv_tax_num);
  END;