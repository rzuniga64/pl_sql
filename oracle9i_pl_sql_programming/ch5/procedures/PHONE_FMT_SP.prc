CREATE OR REPLACE PROCEDURE phone_fmt_sp
   (p_phone IN OUT VARCHAR2)
  IS
BEGIN
  p_phone := '(' || SUBSTR(p_phone,1,3) || ')' ||
                    SUBSTR(p_phone,4,3) || '-' ||
                    SUBSTR(p_phone,7,4);
END;
/