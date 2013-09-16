--FIGURE 3-21 An UPDATE with a record variable
DECLARE
  rec_dept bb_department%ROWTYPE;
BEGIN
  rec_dept.iddepartment := 4;
  rec_dept.deptdesc := 'Premium teas from around the world';
  rec_dept.deptimage := 'tea.gif';
  UPDATE bb_department SET ROW = rec_dept
    WHERE iddepartment = rec_dept.iddepartment;
END;