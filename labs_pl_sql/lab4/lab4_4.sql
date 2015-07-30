/*
	Modify and add to data to your Physician, Patient, and Treatment tables so that the tables look like the 
	following. Also be sure that the Primary Key and Foriegn Key constraints are still in effect.  Note that

	1. Assume that a treatment procedure can be given to a patient only once on a given date
	2. A patient can receive the same treatment procedure from a different physician.
*/
DECLARE 
  rec_patient patient%ROWTYPE;
  rec_treatment treatment%ROWTYPE;
BEGIN
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