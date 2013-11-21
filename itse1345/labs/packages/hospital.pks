/* 
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 part 2		
	Purpose: Construct a PL/SQL package named Hospital which operates on the Physician, 
	Treatment, and Patient tables as you did in Lab 3 by creating your own tables.
*/
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
  
  -- Record used to verify update or insert from newpatient_pp
	rec_patient patient%ROWTYPE;
  
  -- Record used to verify update or insert from newtreatment_pp
	rec_treatment treatment%ROWTYPE;
  
  -- One exception: Named e_DupPhysFound
  e_DupPhysFound EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_DupPhysFound, -00001);
    
  -- A procedure name buildpattbl which will build a table of 
  -- all treatments for all patients.
  PROCEDURE buildpattbl_pp(po_pat_trt_table OUT t_pattrt);
  
  -- A procedure named NewPhys which inserts a new physician in the
  -- physician table or updates it
  PROCEDURE newphys_pp(p_physician_record IN physician%ROWTYPE);  
  
  -- A procedure named NewPatient which inserts a new patient in the
  -- patient table or updates it 
  PROCEDURE newpatient_pp(p_patient_record IN patient%ROWTYPE);
  
  -- A procedure named NewTreatment which inserts a new patient in the
  -- treatment table or updates it   
  PROCEDURE newtreatment_pp(p_trt_record IN treatment%ROWTYPE);
  
  -- Two overloaded functions name FindPatient which checks to see 
  -- if a patient is in the data base ither by patient number or name.
  FUNCTION find_patient_pp(p_pat_nbr IN patient.pat_nbr%TYPE)
    RETURN BOOLEAN;
  FUNCTION find_patient_pp(p_pat_fname IN patient.pat_fname%TYPE,
                            p_pat_lname IN patient.pat_lname%TYPE)
    RETURN BOOLEAN;
END hospital;
------------------------------------------------------------------------
create or replace 
PACKAGE BODY hospital IS
/*
 	A procedure named BuildPatTbl,  which will build a table of all treatments
 	for all patients.  The table will be an OUT parameter. A second
 	IN OUT will be the number of rows return in the table.  The indexes
 	in the table will start at 1 and be incremented by 1.  For each treatment,
	include pat_nbr, trt_procedure, phys_id, phys_name, and phys_specialty
	in the table.
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
/*
	A procedure named NewPHys which inserts a new physician into the physician
	table.  The input parameters are: Phys_ID, Phys_Name, Phys_Phone, and 
	Phys_Specialty.  The procedure should check to see if the physician is
	already in the table.  If he/she is in the table, raise the exception
	e_DupPhysFound.  Do not check for any exceptions in this procedure.
*/
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
      DBMS_OUTPUT.PUT_LINE('e_DupPhysfound exception: value for Phys_Id is in the Physician table ');				 
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
PROCEDURE newpatient_pp(p_patient_record IN patient%ROWTYPE)
AS 
BEGIN
	-- If the value for Pat_Nbr is not in the Patient Table, a row is inserted 
	-- using INSERT into the Patient Table with those values.  
  INSERT INTO patient VALUES p_patient_record
  RETURNING pat_nbr, pat_fname, pat_lname, pat_address, pat_city, pat_state, pat_zip, pat_room, pat_bed
  INTO rec_patient;
  DBMS_OUTPUT.PUT_LINE('Inserting into patient table with record using function newpatient_pp: ');
  DBMS_OUTPUT.PUT_LINE('Patient Number: ' || rec_patient.pat_nbr);
  DBMS_OUTPUT.PUT_LINE('Patient First Name: ' || rec_patient.pat_fname);
  DBMS_OUTPUT.PUT_LINE('Patient Last Name: ' || rec_patient.pat_lname);
  DBMS_OUTPUT.PUT_LINE('Patient Address: ' || rec_patient.pat_address);	
  DBMS_OUTPUT.PUT_LINE('Patient City: ' || rec_patient.pat_city); 
  DBMS_OUTPUT.PUT_LINE('Patient State: ' || rec_patient.pat_state);   
  DBMS_OUTPUT.PUT_LINE('Patient Zip: ' || rec_patient.pat_zip);
  DBMS_OUTPUT.PUT_LINE('Patient Room: ' || rec_patient.pat_room);
  DBMS_OUTPUT.PUT_LINE('Patient Bed: ' || rec_patient.pat_bed);
  DBMS_OUTPUT.PUT_LINE(' ');   
  COMMIT;
EXCEPTION 
  WHEN e_DupPhysFound THEN 
    -- If the value for Phys_ID is in the Physician Table, the values of the 
    -- remaining columns are updated using UPDATE.	
    UPDATE patient SET ROW = p_patient_record
      WHERE pat_nbr = p_patient_record.pat_nbr
      RETURNING pat_nbr, pat_fname, pat_lname, pat_address, pat_city, pat_state, pat_zip, pat_room, pat_bed
  		INTO rec_patient;     
      DBMS_OUTPUT.PUT_LINE('Updating patient table with record using function newpatient_pp: ');
      DBMS_OUTPUT.PUT_LINE('Patient Number: ' || rec_patient.pat_nbr);
      DBMS_OUTPUT.PUT_LINE('Patient First Name: ' || rec_patient.pat_fname);
      DBMS_OUTPUT.PUT_LINE('Patient Last Name: ' || rec_patient.pat_lname);
      DBMS_OUTPUT.PUT_LINE('Patient Address: ' || rec_patient.pat_address);	
      DBMS_OUTPUT.PUT_LINE('Patient City: ' || rec_patient.pat_city); 
      DBMS_OUTPUT.PUT_LINE('Patient State: ' || rec_patient.pat_state);   
      DBMS_OUTPUT.PUT_LINE('Patient Zip: ' || rec_patient.pat_zip);
      DBMS_OUTPUT.PUT_LINE('Patient Room: ' || rec_patient.pat_room);
      DBMS_OUTPUT.PUT_LINE('Patient Bed: ' || rec_patient.pat_bed);
      DBMS_OUTPUT.PUT_LINE(' ');  
      COMMIT;	
END newpatient_pp;
------------------------------------------------------------------------
PROCEDURE newtreatment_pp(p_trt_record IN treatment%ROWTYPE)
AS 
  CURSOR cursor_treatment IS
    SELECT * 
    FROM treatment;
    
    dup_trt_on_same_day EXCEPTION;
BEGIN
  FOR trt IN cursor_treatment LOOP
    IF (trt.pat_nbr = p_trt_record.pat_nbr) AND (trt.trt_procedure = p_trt_record.trt_procedure) AND (trt.trt_date = p_trt_record.trt_date) THEN
      RAISE dup_trt_on_same_day;
    END IF;
  END LOOP;
	-- If the value for Pat_Nbr is not in the Patient Table, a row is inserted 
	-- using INSERT into the Patient Table with those values.  
  INSERT INTO treatment VALUES p_trt_record
  RETURNING pat_nbr, phys_id, trt_procedure, trt_date
  INTO rec_treatment;
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Inserting into treatment table with record using function hospital.newtreatment_pp: ');
  DBMS_OUTPUT.PUT_LINE('Patient Number: ' || rec_treatment.pat_nbr);
  DBMS_OUTPUT.PUT_LINE('Physican ID: ' || rec_treatment.phys_id);
  DBMS_OUTPUT.PUT_LINE('Treatment Procedure: ' || rec_treatment.trt_procedure);
  DBMS_OUTPUT.PUT_LINE('Treatment Date: ' || rec_treatment.trt_date);	
  DBMS_OUTPUT.PUT_LINE(' ');   	
EXCEPTION 
  WHEN dup_trt_on_same_day THEN
      DBMS_OUTPUT.PUT_LINE('A treatment procedure cannot be given to a patient more than once on same day:');
      DBMS_OUTPUT.PUT_LINE('Patient Number: ' || p_trt_record.pat_nbr);
      DBMS_OUTPUT.PUT_LINE('Treatment Procedure: ' || p_trt_record.trt_procedure);
      DBMS_OUTPUT.PUT_LINE('Treatment Date: ' || p_trt_record.trt_date);
      DBMS_OUTPUT.PUT_LINE(' ');   
END newtreatment_pp;
------------------------------------------------------------------------
/*
	Two overload functions, both named FindPatient, to check to see if a
	patient is in the database either by patient number or name. That is, 
	the input value could be either the patient number or name.  RETURN 
	true, if the patient is found, FALSE if the patient is not found.
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