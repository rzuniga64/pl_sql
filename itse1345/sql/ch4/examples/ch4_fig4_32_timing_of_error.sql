/*
  Figure 4-31 Timing of error propagation
  
  Look at the exception handler modified to contain
  a DMBS_OUTPUT  statement before the error is raised
  in the exception handler.  The output shows that 
  lines from exception handlers in both the nested
  and enclosing blocks are processed.
*/
DECLARE
  lv_junk1_num NUMBER(3) := 200;
BEGIN
  DECLARE
    lv_junk2_num NUMBER(3);
  BEGIN
    lv_junk2_num := 'cat';
  EXCEPTION
    WHEN OTHERS THEN 
      DBMS_OUTPUT.PUT_LINE('Handler in nested block');
      lv_junk2_num := 'bat';
  END;
  lv_junk1_num := 300;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Handler is outer block');
END;