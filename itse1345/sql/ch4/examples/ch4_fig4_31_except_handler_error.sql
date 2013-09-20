/*
  Figure 4-301 Error in exception handler
  
  An error can also occur in the EXCEPTION section, which
  can be an Oracle error raised automatically or a user-defined
  error raised explicitly.  In this case, the exception propoagates
  to the enclosing block when the error occurs. Figure 4-31 shows
  a nested block with an error in the executable section and an 
  error in the matching exception handler.  The WHEN OTHERS 
  exception handler in the enclosing block is now executed.
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
    lv_junk2_num := 'bat';
      DBMS_OUTPUT.PUT_LINE('Handler in nested block');
  END;
  lv_junk1_num := 300;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Handler is outer block');
END;