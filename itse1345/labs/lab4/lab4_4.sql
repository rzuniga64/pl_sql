DECLARE 
  rec_patient patient%ROWTYPE;
  rec_treatment treatment%ROWTYPE;
BEGIN
/*
	-- Test a Pat_Nbr that is in the Patient Table. 
  rec_patient.pat_nbr := 1379;
  rec_patient.pat_fname := 'Chris';
  rec_patient.pat_lname := 'Plummer';
  rec_patient.pat_address := '2110 Main St.';
  rec_patient.pat_city := 'Austin';
  rec_patient.pat_state := 'TX';
  rec_patient.pat_zip := '78711';
  rec_patient.pat_room := '101';
  rec_patient.pat_bed := '2';  
  
  -- This will update the patient table
  hospital.newpatient_pp(rec_patient);
  */
  -- Test a Pat_Nbr that is in the Patient Table
  -- where a duplicate procedure is given more 
  -- than once on a given day
  rec_treatment.pat_nbr := 1379;
  rec_treatment.phys_id := 103;
  rec_treatment.trt_procedure := '27-45';
  rec_treatment.trt_date := '25-MAR-1999';
  
  hospital.newtreatment_pp(rec_treatment);
    
  -- Test a Pat_Nbr that is in the Patient Table
  -- where a patient can receive a procedure from
  -- a different physician (but  not the same
  -- procedure on the same day)
  rec_treatment.pat_nbr := 1379;
  rec_treatment.phys_id := 104;
  rec_treatment.trt_procedure := '27-45';
  rec_treatment.trt_date := '15-MAY-1999';
  
  hospital.newtreatment_pp(rec_treatment);
  
  -- Test a Pat_Nbr that is NOT in the Patient Table.
  -- This will do an insert into the table.
--  rec_treatment.pat_nbr := 1000;
--  rec_treatment.phys_id := 105;
--  rec_treatment.trt_procedure := '27-45';
--  rec_treatment.trt_date := '20-APR-1999';
  
--  hospital.newtreatment_pp(rec_treatment);
  
END;
/