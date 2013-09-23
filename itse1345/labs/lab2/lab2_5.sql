DECLARE
	lv_num_courses NUMBER;
BEGIN
	SELECT count(DISTINCT course_id) 
		INTO lv_num_courses
		FROM enroll;
		
	IF lv_num_courses >= 10 THEN
		DBMS_OUTPUT.PUT_LINE('10 or more courses have been established: ' || lv_num_courses);
	ELSIF lv_num_courses < 10 THEN
		DBMS_OUTPUT.PUT_LINE('Less than 10 courses have been established: ' || lv_num_courses);
	END IF;
END;
/