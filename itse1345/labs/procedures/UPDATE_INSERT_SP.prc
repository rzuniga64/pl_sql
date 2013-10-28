create or replace 
PROCEDURE UPDATE_INSERT_SP 
  (p_physician_record IN physician%ROWTYPE)
AS 
BEGIN
  -- If the value for Phys_ID is in the Physician Table, the values of the 
	-- remaining columns are updated using UPDATE.	
  UPDATE physician SET ROW = p_physician_record
    WHERE phys_id = p_physician_record.phys_id; 
	-- If the value for Phys_ID is not in the Physician Table, a row is inserted 
	-- using INSERT into the Physician Table with those values.   
  IF SQL%ROWCOUNT = 0 THEN 
    INSERT INTO physician VALUES p_physician_record;
  END IF;
  COMMIT;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found error');
END;