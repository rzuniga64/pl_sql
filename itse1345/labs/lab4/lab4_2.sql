DECLARE 
  pat_trt_table hospital.type_treatment;
  rec_physician1 physician%ROWTYPE;
  rec_physician2 physician%ROWTYPE;
  lv_phys_id NUMBER;
BEGIN
	SELECT phys_id_seq.NEXTVAL
	INTO lv_phys_id
	FROM DUAL;
	
	-- Attempt to insert a physician who already exists in the Physician table.
  	rec_physician1.phys_id := 101;
  	rec_physician1.phys_fname := 'Christopher';
  	rec_physician1.phys_lname := 'Plummer';
  	rec_physician1.phys_phone := '512-329-1848';
  	rec_physician1.phys_specialty := 'Dermatology';
  
	-- Insert a new physician into the Physician table 
  	rec_physician2.phys_id := lv_phys_id;
  	rec_physician2.phys_fname := 'David';
  	rec_physician2.phys_lname := 'House';
  	rec_physician2.phys_phone := '512-554-2148';
  	rec_physician2.phys_specialty := 'Chiropractic';
  
  	hospital.newphys_pp(rec_physician1);
  	hospital.newphys_pp(rec_physician2);
------------------------------------------------------------------------  	
	hospital.buildpattbl(pat_trt_table);
  
  	DBMS_OUTPUT.PUT_LINE(lpad('Patient Number',14) 
  							|| lpad('Treatment',10) 
							|| lpad('Physician ID',15) 
							|| lpad('Physician Last Name',25) 
							|| lpad('Physician First Name',25) 
							|| lpad('Physician Specialty',25) );
  	FOR i IN pat_trt_table.FIRST..pat_trt_table.LAST LOOP
    	DBMS_OUTPUT.PUT_LINE(lpad(pat_trt_table(i).pat_nbr,14) 
                          || lpad(pat_trt_table(i).trt_procedure,10)
                          || lpad(pat_trt_table(i).phys_id,15)
                          || lpad(pat_trt_table(i).phys_lname,25)
                          || lpad(pat_trt_table(i).phys_fname,25)
                          || lpad(pat_trt_table(i).phys_specialty,25)
                          );
  	END LOOP;
END;
/