CREATE OR REPLACE PROCEDURE GET_SEX_MAJOR_USING_CASE_SP (lv_student IN enroll.stu_id%TYPE)
AS
   CURSOR cursor_student
   IS
      SELECT stu_id, sex, major FROM student;
BEGIN
   FOR student_record IN cursor_student
   LOOP
      	IF student_record.stu_id = lv_student THEN 
      IF UPPER (student_record.sex) = 'M'
      THEN
         DBMS_OUTPUT.PUT_LINE (
               'Student '
            || student_record.stu_id
            || ' is a male');
      ELSIF UPPER (student_record.sex) = 'F'
      THEN
         DBMS_OUTPUT.PUT_LINE (
               'Student '
            || student_record.stu_id
            || ' is a female');
      END IF;
	  
	  CASE
	  	WHEN student_record.major = 'Math' THEN
			DBMS_OUTPUT.PUT_LINE ('Student '
            		|| student_record.stu_id
            		|| '''s major is '
		 	|| student_record.major);	
	  	WHEN student_record.major = 'English' THEN
			DBMS_OUTPUT.PUT_LINE ('Student '
            		|| student_record.stu_id
            		|| '''s major is '
			|| student_record.major);
	  	WHEN student_record.major = 'CompSci' THEN
			DBMS_OUTPUT.PUT_LINE ('Student '
            		|| student_record.stu_id
            		|| '''s major is '
			|| student_record.major);	
	  	WHEN student_record.major = 'Geography' THEN
			DBMS_OUTPUT.PUT_LINE ('Student '
            		|| student_record.stu_id
            		|| '''s major is '
			|| student_record.major);						
		END CASE;
		END IF;
END LOOP;
END;
/
