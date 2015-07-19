-- Assignment 3-2: Using a Record Variable
-- Figure 3-31 using a record variable to retrieve shipping information
DECLARE
  rec_ship bb_basketstatus%ROWTYPE;
  lv_bask_num bb_basketstatus.idbasket%TYPE := 3;
BEGIN
  SELECT *
   INTO rec_ship
   FROM bb_basketstatus
   WHERE idbasket =  lv_bask_num
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('ID Status: '||rec_ship.idstatus);	
  DBMS_OUTPUT.PUT_LINE('ID Basket: '||rec_ship.idbasket); 
  DBMS_OUTPUT.PUT_LINE('ID Stage:  '||rec_ship.idstage);  
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||rec_ship.dtstage);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||rec_ship.shipper);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||rec_ship.shippingnum);
  DBMS_OUTPUT.PUT_LINE('Notes: '||rec_ship.notes);
END;
