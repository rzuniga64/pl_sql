 /* 
 	An anonymous block which updates the Physician table. This program uses named 
	parameters to get values for Phys_ID, Phys_name, Phys_phone, and Phys_speciality. 
	
	A simple driver is used to test the block
	- Test a Phys_ID that is in the Physician Table. If the value for Phys_ID is in 
	  the Physician Table, the values of the remaining columns are updated using UPDATE.
    - Test a Phys_ID that is not in the Physician Table. If the value for Phys_ID is 
	  not in the Physician Table, a row is inserted using INSERT into the Physician Table with those values.
*/
DECLARE
  rec_physician1 physician%ROWTYPE;
  rec_physician2 physician%ROWTYPE;
  lv_phys_id NUMBER;
BEGIN
	SELECT phys_id_seq.NEXTVAL
	INTO lv_phys_id
	FROM DUAL;
	
	-- Test a Phys_ID that is in the Physician Table. 
  rec_physician1.phys_id := 101;
  rec_physician1.phys_fname := 'Christ';
  rec_physician1.phys_lname := 'Plummer';
  rec_physician1.phys_phone := '512-329-1848';
  rec_physician1.phys_specialty := 'Dermatology';
  
	-- Test a Phys_ID that is not in the Physician Table. 
  rec_physician2.phys_id := lv_phys_id;
  rec_physician2.phys_fname := 'David';
  rec_physician2.phys_lname := 'House';
  rec_physician2.phys_phone := '512-554-2148';
  rec_physician2.phys_specialty := 'Chiropractic';
  
	-- If the value for Phys_ID is not in the Physician Table, a row is inserted 
	-- using INSERT into the Physician Table with those values.  
  INSERT INTO physician VALUES rec_physician2;
  COMMIT;
  INSERT INTO physician VALUES rec_physician1;
  COMMIT;
EXCEPTION
	-- If the value for Phys_ID is in the Physician Table, the values of the 
	-- remaining columns are updated using UPDATE.		
	WHEN DUP_VAL_ON_INDEX THEN
    UPDATE physician SET ROW = rec_physician1
      WHERE phys_id = rec_physician1.phys_id;
END;
/