/*
	Purpose: To retrieve and list the data for a given employee
	Input Parameter: The employee number
	Input/Output parameters: None
	Output Parameters: None
	Preconditions: 	The employee number should exist. If he/she does not exist, handle it with an
   		          	exception and appropriate message. 
	Post Conditions: Print out each column in the employee row. The employee table is unchanged.
	           		- Use %ROWTYPE to define a structure in which to store the column values.
	           		- Write a simple driver to call and test the procedure.
	           		- Test one valid employee (Empno = 7654) and one invalid employee (Empno = 7888)
*/
CREATE OR REPLACE
PROCEDURE get_emp_data_sp
	(lv_empno IN NUMBER)
AS
	lv_emp emp%ROWTYPE;
BEGIN
	SELECT * INTO lv_emp
	FROM emp
	WHERE empno = lv_empno;
		
	DBMS_OUTPUT.PUT_LINE(lpad('Employee No.: ',15) 	|| lv_emp.empno);	
	DBMS_OUTPUT.PUT_LINE(lpad('Name: ',15) 	  		|| lv_emp.ename);
	DBMS_OUTPUT.PUT_LINE( lpad('Job: ',15)  	  	|| lv_emp.job); 
	DBMS_OUTPUT.PUT_LINE( lpad('Manager: ',15) 	  	|| lv_emp.mgr);
	DBMS_OUTPUT.PUT_LINE( lpad('Hire Date: ',15)  	|| lv_emp.hiredate);
	DBMS_OUTPUT.PUT_LINE( lpad('Salary: ',15)	  	|| lv_emp.sal);
	DBMS_OUTPUT.PUT_LINE( lpad('Commission: ',15) 	|| lv_emp.comm);
	DBMS_OUTPUT.PUT_LINE( lpad('Department No: ',15)|| lv_emp.deptno);
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE(' ');		
		DBMS_OUTPUT.PUT_LINE('No employee was found with employee number');
END;
/