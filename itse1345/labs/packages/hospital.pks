create or replace 
PACKAGE BODY hospital IS
/*
 	buildpattbl is a procedure which will build a table of all treatments
 	for all patients.  The table will be an OUT parameter. A second
 	IN OUT will be the number of rows return in the table.  The indexes
 	in the table will start at 1 and be incremented by 1.  For each treatment,
	include pat_nbr, trt_procedure, phys_id, phys_name, and phys_specialty
 */
PROCEDURE buildpattbl_pp(po_pat_trt_table OUT t_pattrt) IS
BEGIN
   SELECT t.pat_nbr,
          t.trt_procedure,
          phys_id,
          p.phys_fname,
          p.phys_lname,
          p.phys_specialty
     BULK COLLECT INTO po_pat_trt_table
     FROM treatment t JOIN physician p USING (phys_id);
END buildpattbl_pp;
------------------------------------------------------------------------
PROCEDURE newphys_pp(p_physician_record IN physician%ROWTYPE)
AS 
BEGIN
	-- If the value for Phys_ID is not in the Physician Table, a row is inserted 
	-- using INSERT into the Physician Table with those values.  
  INSERT INTO physician VALUES p_physician_record
  RETURNING phys_id, phys_fname, phys_lname, phys_phone, phys_specialty
  INTO rec_physician;
  DBMS_OUTPUT.PUT_LINE('Inserting into physician table with record using function newphys_pp: ');
  DBMS_OUTPUT.PUT_LINE('Physician ID: ' || rec_physician.phys_id);
  DBMS_OUTPUT.PUT_LINE('Physican First Name: ' || rec_physician.phys_fname);
  DBMS_OUTPUT.PUT_LINE('Physician Last Name: ' || rec_physician.phys_lname);
  DBMS_OUTPUT.PUT_LINE('Physician Phone: ' || rec_physician.phys_phone);	
  DBMS_OUTPUT.PUT_LINE('Physician Specialty: ' || rec_physician.phys_specialty); 
  DBMS_OUTPUT.PUT_LINE(' ');   
  COMMIT;
EXCEPTION 
  WHEN e_DupPhysFound THEN 
    -- If the value for Phys_ID is in the Physician Table, the values of the 
    -- remaining columns are updated using UPDATE.	
    UPDATE physician SET ROW = p_physician_record
      WHERE phys_id = p_physician_record.phys_id
      RETURNING phys_id, phys_fname, phys_lname, phys_phone, phys_specialty
  		INTO rec_physician;     
      DBMS_OUTPUT.PUT_LINE('Updating physician table with record using function newphys_pp: ');		
      DBMS_OUTPUT.PUT_LINE('Physician ID: ' || rec_physician.phys_id);
      DBMS_OUTPUT.PUT_LINE('Physican First Name: ' || rec_physician.phys_fname);
      DBMS_OUTPUT.PUT_LINE('Physician Last Name: ' || rec_physician.phys_lname);
      DBMS_OUTPUT.PUT_LINE('Physician Phone: ' || rec_physician.phys_phone);	
      DBMS_OUTPUT.PUT_LINE('Physician Specialty: ' || rec_physician.phys_specialty); 
      DBMS_OUTPUT.PUT_LINE(' ');       
      COMMIT;	
END newphys_pp;
END hospital;