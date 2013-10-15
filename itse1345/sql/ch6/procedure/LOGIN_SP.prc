CREATE OR REPLACE PROCEDURE login_sp
 (p_user IN VARCHAR2,
  p_pass IN VARCHAR2,
  p_id OUT NUMBER,
  p_flag OUT CHAR,
  p_mem OUT VARCHAR2 )
 IS
  lv_first_txt bb_shopper.firstname%TYPE;
  lv_last_txt bb_shopper.lastname%TYPE;
BEGIN
 SELECT idShopper, firstname, lastname
  INTO p_id, lv_first_txt, lv_last_txt
  FROM bb_shopper
  WHERE username = p_user
   AND password = p_pass;
  p_flag := 'Y';
  p_mem := memfmt1_sf(p_id, lv_first_txt, lv_last_txt);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    p_flag := 'N';
END;