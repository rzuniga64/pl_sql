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
  
  update_insert_sp(rec_physician1);
  update_insert_sp(rec_physician2);  
END;
/