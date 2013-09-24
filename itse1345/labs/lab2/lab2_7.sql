DECLARE
	lv_student_id enroll.stu_id%TYPE := 10003;
BEGIN
	get_courses_sp(lv_student_id);
END;
/