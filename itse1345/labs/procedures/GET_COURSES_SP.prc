CREATE OR REPLACE
PROCEDURE GET_COURSES_SP
	(lv_student IN enroll.stu_id%TYPE)
AS
	CURSOR cursor_student IS
		SELECT stu_id, course_id
		FROM enroll;
BEGIN
	DBMS_OUTPUT.PUT_LINE('List of courses for student ' || lv_student);
	FOR student_record IN cursor_student LOOP
		IF student_record.stu_id = lv_student THEN
			DBMS_OUTPUT.PUT_LINE(student_record.course_id);
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(' ');	
END;
/

