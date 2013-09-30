DECLARE
	lv_student_id enroll.stu_id%TYPE := 10001;
BEGIN
	get_courses_using_if(lv_student_id);
END;
/