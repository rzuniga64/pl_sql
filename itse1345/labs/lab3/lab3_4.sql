DECLARE
  rec_physician1 physician%ROWTYPE;
  rec_physician2 physician%ROWTYPE;
  lv_phys_id NUMBER;
BEGIN
	SELECT phys_id_seq.NEXTVAL
	INTO lv_phys_id
	FROM DUAL;
	
  rec_physician1.phys_id := 101;
  rec_physician1.phys_fname := 'Christ';
  rec_physician1.phys_lname := 'Plummer';
  rec_physician1.phys_phone := '512-329-1848';
  rec_physician1.phys_specialty := 'Dermatology';
  
  rec_physician2.phys_id := lv_phys_id;
  rec_physician2.phys_fname := 'David';
  rec_physician2.phys_lname := 'House';
  rec_physician2.phys_phone := '512-554-2148';
  rec_physician2.phys_specialty := 'Chiropractic';
  
  INSERT INTO physician VALUES rec_physician2;
  COMMIT;
  INSERT INTO physician VALUES rec_physician1;
  COMMIT;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    UPDATE physician SET ROW = rec_physician1
      WHERE phys_id = rec_physician1.phys_id;
END;