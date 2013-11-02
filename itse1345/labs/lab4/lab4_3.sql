DECLARE 
	-- Declare a table of the type t_PatTrt.	
	pat_trt_table hospital.t_pattrt;
  	rec_physician1 physician%ROWTYPE;
  	rec_physician2 physician%ROWTYPE;
  	lv_phys_id NUMBER;
BEGIN
	SELECT phys_id_seq.NEXTVAL
	INTO lv_phys_id
	FROM DUAL;
	
	/* 	Use the NewPhys procedure to:
		1. Insert a new physician into the Physician table
		2. Attempt to insert a physician who already exists in the Physician table
		3. check for the exception e_DupPhysFound in this driver
	*/

  	rec_physician1.phys_id := 101;
  	rec_physician1.phys_fname := 'Christopher';
  	rec_physician1.phys_lname := 'Plummer';
  	rec_physician1.phys_phone := '512-329-1848';
  	rec_physician1.phys_specialty := 'Dermatology';
  
  	rec_physician2.phys_id := lv_phys_id;
  	rec_physician2.phys_fname := 'David';
  	rec_physician2.phys_lname := 'House';
  	rec_physician2.phys_phone := '512-554-2148';
  	rec_physician2.phys_specialty := 'Chiropractic';
  
  	-- Insert a new physician into the Physician table 	
  	hospital.newphys_pp(rec_physician2);
	
	-- Attempt to insert a physician who already exists in the Physician table.  
  	hospital.newphys_pp(rec_physician1);
------------------------------------------------------------------------  	
	/*
	 	Declare a table of the type t_ParTrt.
	 	Call the Procedure BuildPatTbl which will store patients and treatments in the above table. 
	 	List the patients returned in the table. List all fields in the table for each patient.
	*/
	
	hospital.buildpattbl_pp(pat_trt_table);  -- Declare pat_trt_table of the type t_PatTrt
  
    -- Send the data of the pat_trt_table to DBMS_OUTPUT
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
	DBMS_OUTPUT.PUT_LINE(' ');
END;
/