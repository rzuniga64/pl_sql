CREATE OR REPLACE PROCEDURE GET_STUDENT_INFO_SP
AS
	CURSOR cursor_student IS
		SELECT *
		FROM student;
BEGIN
	DBMS_OUTPUT.PUT_LINE(lpad('Student ID',10) || lpad('Last Name',11) || lpad('First Name',13) || lpad('Middle Initial',15) || lpad('Sex',5) || lpad('Major',10) || lpad('State',8));	
	FOR student_record IN cursor_student LOOP
		IF student_record.mi IS NOT NULL THEN
			DBMS_OUTPUT.PUT_LINE(lpad(student_record.stu_id, 10) ||  lpad(student_record.lname,11) 
									|| lpad(student_record.fname,13) || lpad(student_record.mi,15) 
									|| lpad(student_record.sex,5) || lpad(student_record.major,10) 
									|| lpad(student_record.home_state,8));
		ELSE
			DBMS_OUTPUT.PUT_LINE(lpad(student_record.stu_id, 10) ||  lpad(student_record.lname,11) 
									|| lpad(student_record.fname,13) || lpad(student_record.mi,15) 
									|| lpad(student_record.sex,20) || lpad(student_record.major,10) 
									|| lpad(student_record.home_state,8));
		END IF;
	END LOOP;
END;
/
