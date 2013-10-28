create or replace 
PROCEDURE UPDATE_INSERT2_SP 
  (p_physician_record IN physician%ROWTYPE)
AS 
BEGIN
	-- If the value for Phys_ID is not in the Physician Table, a row is inserted 
	-- using INSERT into the Physician Table with those values.   
  INSERT INTO physician VALUES p_physician_record;
  COMMIT;
EXCEPTION 
  -- If the value for Phys_ID is in the Physician Table, the values of the 
	-- remaining columns are updated using UPDATE.	
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE physician SET ROW = p_physician_record
        WHERE phys_id = p_physician_record.phys_id;
    COMMIT;
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No data found error');
END;
