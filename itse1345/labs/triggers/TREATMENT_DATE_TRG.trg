/*
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 part 5
	PURPOSE: Write a Trigger for inserting into or updating the treatment table, 
	which checks the treatment date to ensure that it is no later than today and 
	no earlier than 3 months ago.  If it violates this constraint, raise an 
	application error (-20100, 'Invalide treatment table').
*/
CREATE OR REPLACE TRIGGER treatment_date_trg
FOR INSERT OR UPDATE OF trt_date ON treatment
COMPOUND TRIGGER
  CURSOR trt_date_cur IS
    SELECT pat_nbr, trt_date
    FROM treatment;
  TYPE trt_date_type IS TABLE OF trt_date_cur%ROWTYPE
    INDEX BY PLS_INTEGER;
  trt_date_table trt_date_type;
  i  NUMBER(2) := 0;
BEFORE STATEMENT IS
  BEGIN
  FOR rec IN trt_date_cur LOOP
    i := i + 1;
    trt_date_table(i).pat_nbr := rec.pat_nbr;
    trt_date_table(i).trt_date := rec.trt_date;
  END LOOP;
END BEFORE STATEMENT;
BEFORE EACH ROW IS
  lv_trt_date DATE;
BEGIN
  FOR j in 1..trt_date_table.COUNT LOOP
    IF trt_date_table(j).pat_nbr = :NEW.pat_nbr THEN
      lv_trt_date := trt_date_table(j).trt_date;
      EXIT;
    END IF;
  END LOOP;
  IF :NEW.trt_date > SYSDATE OR :NEW.trt_date < ADD_MONTHS(SYSDATE,-3) THEN
    RAISE_APPLICATION_ERROR(-20100, 'Invalid treatment date');
  END IF;
END BEFORE EACH ROW;
END;