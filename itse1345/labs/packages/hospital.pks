CREATE OR REPLACE PACKAGE hospital IS
	TYPE type_treatment_record IS RECORD(
		pat_nbr treatment.pat_nbr%TYPE,
		trt_procedure treatment.trt_procedure%TYPE,
		phys_id treatment.phys_id%TYPE,
		phys_fname physician.phys_fname%TYPE,
		phys_lname physician.phys_lname%TYPE,
		phys_specialty physician.phys_specialty%TYPE
		);
    
	TYPE type_treatment IS TABLE of type_treatment_record
		INDEX BY BINARY_INTEGER;
    
  PROCEDURE buildpattbl(po_patient_treatment OUT type_treatment);
  PROCEDURE newphys_pp(p_physician_record IN physician%ROWTYPE);  
END hospital;
/
------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY hospital IS

PROCEDURE buildpattbl(po_patient_treatment OUT type_treatment) IS
BEGIN
   SELECT t.pat_nbr,
          t.trt_procedure,
          phys_id,
          p.phys_fname,
          p.phys_lname,
          p.phys_specialty
     BULK COLLECT INTO po_patient_treatment
     FROM treatment t JOIN physician p USING (phys_id);
END;
------------------------------------------------------------------------
PROCEDURE newphys_pp(p_physician_record IN physician%ROWTYPE)
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
END hospital;
/