--  FIGURE 3-23 Using a record variable in a RETURNING clause
DECLARE
	rec_dept bb_department%ROWTYPE;
BEGIN
	UPDATE bb_department
	SET deptname = 'Teas'
	WHERE iddepartment = 3
	RETURNING iddepartment, deptname, deptdesc, deptimage
	INTO rec_dept;
	DBMS_OUTPUT.PUT_LINE(rec_dept.iddepartment);
	DBMS_OUTPUT.PUT_LINE(rec_dept.deptname);
	DBMS_OUTPUT.PUT_LINE(rec_dept.deptdesc);
	DBMS_OUTPUT.PUT_LINE(rec_dept.deptimage);
END;