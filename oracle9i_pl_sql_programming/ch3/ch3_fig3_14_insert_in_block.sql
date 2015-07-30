--FIGURE 3-14 Performing an INSERT INTO in a block
DECLARE 
  lv_firstname bb_shopper.firstname%TYPE := 'Jeffrey';
  lv_lastname bb_shopper.lastname%TYPE := 'Brand';
  lv_email bb_shopper.email%TYPE := 'jbrand@site.com';
BEGIN
  INSERT INTO bb_shopper(idshopper, firstname, lastname, email)
    VALUES (bb_shopper_seq.NEXTVAL, lv_firstname, lv_lastname, lv_email);
  COMMIT;
END;
