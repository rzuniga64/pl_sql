CREATE OR REPLACE FUNCTION test_out_sf
  (p_var1 IN OUT number)
 RETURN varchar2
 IS
  lv_test_txt varchar2(5);
BEGIN
  IF p_var1 = 1 THEN
    lv_test_txt := 'TEST';
  END IF;
  p_var1 := 2;
  RETURN lv_test_txt;
END;