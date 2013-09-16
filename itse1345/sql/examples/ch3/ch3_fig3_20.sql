--FIGURE 3-20 Adding an INSERT statement with a record value
DECLARE
  rec_dept bb_department%ROWTYPE;
BEGIN
  rec_dept.iddepartment := 4;
  rec_dept.deptname := 'Teas';
  rec_dept.deptdesc := 'Premium teas';
  DBMS_OUTPUT.PUT_LINE(rec_dept.deptname);
  INSERT INTO bb_department
    VALUES rec_dept;
END;
