/*
    A simple driver to call and test the procedure GET_EMP_DATA_SP
	- Test one valid employee (Empno = 7654)
   	- Test one invalid employee (Empno = 9999)
*/
DECLARE 
	lv_empno1 NUMBER(4) := 7566;
  	lv_empno2 NUMBER(4) := 9999;
BEGIN
	get_emp_data_sp(lv_empno1);
	get_emp_data_sp(lv_empno2);  
END;
/