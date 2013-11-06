create or replace 
PACKAGE hospital IS
/*
	 t_pattrt is a PL/SQL table which containts a RECORD with the 
	 following fields: pat_nbr, trt_procedure, phys_id, phys_fname,
	 phys_lname, and phys specialty
*/	 
	TYPE type_treatment_record IS RECORD(
		pat_nbr treatment.pat_nbr%TYPE,
		trt_procedure treatment.trt_procedure%TYPE,
		phys_id treatment.phys_id%TYPE,
		phys_fname physician.phys_fname%TYPE,
		phys_lname physician.phys_lname%TYPE,
		phys_specialty physician.phys_specialty%TYPE
		);
    
	TYPE t_pattrt IS TABLE of type_treatment_record
		INDEX BY BINARY_INTEGER;
		
  -- Record used to verify update or insert from newphys_pp
	rec_physician physician%ROWTYPE;
  
  -- If a physican is already in a table when doing an INSERT
  -- raise the exception e_DupPhysFound
  e_DupPhysFound EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_DupPhysFound, -00001);
    
  -- A procedure name BuildPatTbl which will build a table of 
  -- all treatments for all patients.
  PROCEDURE buildpattbl_pp(po_pat_trt_table OUT t_pattrt);
  
  -- A procedure named NewPhys which inserts a new physician in the
  -- physician table or updates it
  PROCEDURE newphys_pp(p_physician_record IN physician%ROWTYPE);  
  
  -- Two overloaded functions name FindPatient which checks to see 
  -- if a patient is in the data base either by patient number or name.
  FUNCTION find_patient_pp(p_pat_nbr IN patient.pat_nbr%TYPE)
    RETURN BOOLEAN;
  FUNCTION find_patient_pp(p_pat_fname IN patient.pat_fname%TYPE,
                            p_pat_lname IN patient.pat_lname%TYPE)
    RETURN BOOLEAN;
END hospital;
------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY hospital IS
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
	/*
		If the value for Phys_ID is not in the Physician Table, a row is inserted 
		using INSERT into the Physician Table with those values.  
	*/
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
------------------------------------------------------------------------
/*
	An overloaded functions name FindPatient which checks to see 
  	if a patient is in the data base either by patient number.
*/
FUNCTION find_patient_pp(p_pat_nbr IN patient.pat_nbr%TYPE) 
    RETURN BOOLEAN
IS 
  lv_pat_flag BOOLEAN;
  lv_patient patient%ROWTYPE;  
BEGIN
    SELECT *
    INTO lv_patient
    FROM patient
    WHERE pat_nbr = p_pat_nbr;
    RETURN SQL%FOUND;
EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
    RETURN SQL%FOUND;
END;
------------------------------------------------------------------------
/*
	An overloaded functions name FindPatient which checks to see 
  	if a patient is in the data base either by patient first and last name.
*/
FUNCTION find_patient_pp(p_pat_fname IN patient.pat_fname%TYPE,
                            p_pat_lname IN patient.pat_lname%TYPE)
    RETURN BOOLEAN
IS 
  lv_pat_flag BOOLEAN;
  lv_patient patient%ROWTYPE;
BEGIN
    SELECT *
    INTO lv_patient
    FROM patient
    WHERE pat_fname = p_pat_fname AND pat_lname = p_pat_lname;
    RETURN SQL%FOUND;   
EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
    RETURN SQL%FOUND;    
END;
END hospital;