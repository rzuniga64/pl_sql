--Declaring a ROWTYPE variable 

DECLARE 
  rec_shopper bb_shopper%ROWTYPE;
BEGIN
  SELECT *
  INTO rec_shopper
  FROM bb_shopper
  WHERE idshopper = 25;
  DBMS_OUTPUT.PUT_LINE(rec_shopper.lastname);
  DBMS_OUTPUT.PUT_LINE(rec_shopper.address);
  DBMS_OUTPUT.PUT_LINE(rec_shopper.email);
END;