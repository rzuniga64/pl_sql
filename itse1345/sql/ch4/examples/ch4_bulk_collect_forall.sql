/*
	A FORALL statement provides bulk processing for DML activity.
	It must contain a single DML statement and reference collection
	elements by using an index that's declared automatically to iterate 
	through the specified collection.  Different collections can be
	referenced in the SET and WHERE clauses of an UPDATE statement.
	
	The following example processes UPDATE statements for all employees
	where JOB is 'Salesman' .  An array is created to hold all the employee
	IDs used in the WHERE clause of the UPDATE statement.
	
	The FORALL statement instructs the system to 'bulk bind' all the 
	collection elements togehter before sending SQL statements for processing.
 	Again, the results of a group of DML statements are submitted at one time
	instead of each UPDATE statement being submitted seperately.
*/
DECLARE
	TYPE emp_type IS TABLE OF NUMBER 
		INDEX BY BINARY_INTEGER;
	emp_tbl emp_type;
BEGIN
	SELECT empno BULK COLLECT INTO emp_tbl
		FROM bb_employee
		WHERE job = upper('salesman');
	FORALL i IN emp_tbl.FIRST..emp_tbl.LAST
		UPDATE bb_employee
		SET raise = sal * 0.06
		WHERE empno = emp_tbl(i);
	COMMIT;
END;