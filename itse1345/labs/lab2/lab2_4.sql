DECLARE
	lv_num_students NUMBER;
BEGIN
	SELECT count(stu_id) INTO lv_num_students
		FROM enroll
		WHERE course_id IS NOT NULL;

    DBMS_OUTPUT.PUT_LINE('The number of students enrolled is: ' || lv_num_students);
END;
/