REM The PKG_DEPTEST_SP procedure calls the 
REM BASKET_INFO_PP packaged procedure, so 
REM PKG_DEPTEST_SP is dependent on the 
REM ORDER_INFO_PKG package

CREATE OR REPLACE PROCEDURE pkg_deptest_sp
(p_bask NUMBER)
IS
	lv_shop_num NUMBER(4);
	lv_bask_dat DATE;
	lv_name_txt VARCHAR2(25);
BEGIN
	order_info_pkg.basket_info_pp
	(p_bask, lv_shop_num, lv_bask_dat, lv_name_txt);
	DBMS_OUTPUT.PUT_LINE(lv_shop_num);
	DBMS_OUTPUT.PUT_LINE(lv_bask_dat);
	DBMS_OUTPUT.PUT_LINE(lv_name_txt);
END;
/