/*
  Figure 4-30 A DECLARE section error propagates immediately
  
  The lv_junk2_num variable is declared in the nested block 
  as a number, tey the code attempts to initialize it with 
  a character string, which raises an error.  Because the error
  occurs in the DECLARE section, the process moves immediately
  to the enclosing block's EXCEPTION section instead of the block's
  EXCEPTION section.  The output confirms this process flow. Notice
  that both EXCEPTION sections include a WHEN OTHERS handler that 
  processes any errors.
*/
DECLARE
  lv_junk1_num NUMBER(3) := 200;
BEGIN
  DECLARE
    lv_junk2_num NUMBER(3) :='cat';
  BEGIN
    lv_junk2_num := 300;
  EXCEPTION
    WHEN OTHERS THEN 
      DBMS_OUTPUT.PUT_LINE('Handler in nested block');
  END;
  lv_junk1_num := 300;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Handler is outer block');
END;