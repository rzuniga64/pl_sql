create or replace 
PACKAGE order_info_pkg IS
 PROCEDURE basket_info_pp
  (p_basket IN NUMBER,
   p_shop OUT NUMBER,
   p_date OUT DATE,
   p_name OUT VARCHAR2,
   p_mult OUT CHAR);
END;
------------------------------------------------------------------------
create or replace 
PACKAGE BODY order_info_pkg IS
 FUNCTION ship_name_pf  
   (p_basket IN NUMBER)
   RETURN VARCHAR2
  IS
   lv_name_txt VARCHAR2(25);
 BEGIN
  SELECT shipfirstname||' '||shiplastname
   INTO lv_name_txt
   FROM bb_basket
   WHERE idBasket = p_basket;
  RETURN lv_name_txt;
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 END ship_name_pf;
 ------------------------------------------------------------------------
  PROCEDURE basket_info_pp
  (p_basket IN NUMBER,
   p_shop OUT NUMBER,
   p_date OUT DATE,
   p_name OUT VARCHAR2,
   p_mult OUT CHAR)
  IS
  	lv_qty_num NUMBER(2);
 BEGIN
   SELECT idshopper, dtordered, quantity
    INTO p_shop, p_date, lv_qty_num
    FROM bb_basket
    WHERE idbasket = p_basket;
   p_name := ship_name_pf(p_basket);
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
     DBMS_OUTPUT.PUT_LINE('Invalid basket id');
 END basket_info_pp;
END;