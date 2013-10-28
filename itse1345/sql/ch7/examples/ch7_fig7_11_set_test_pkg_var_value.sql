DECLARE
	lv_pkg_num NUMBER(3);
BEGIN
	lv_pkg_num := ordering_pkg.pv_total_num;
	DBMS_OUTPUT.PUT_LINE(lv_pkg_num);
END;
/
DECLARE 
	lv_pkg_num NUMBER(3) := 5;
BEGIN
	ordering_pkg.pv_total_num := lv_pkg_num;
	DBMS_OUTPUT.PUT_LINE(ordering_pkg.pv_total_num);
END;
/
DECLARE
	lv_pkg_num NUMBER(3);
BEGIN
	lv_pkg_num := ordering_pkg.pv_total_num;
	DBMS_OUTPUT.PUT_LINE(lv_pkg_num);
END;
/
/