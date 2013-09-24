DECLARE
  TYPE type_enroll IS RECORD(
    stu_id enroll.stu_id%TYPE,
    num_courses NUMBER
  );
  TYPE type_student IS TABLE OF type_enroll
    INDEX BY BINARY_INTEGER;
  course_count_table type_student;
BEGIN
	SELECT stu_id, count(stu_id) BULK COLLECT INTO course_count_table
		FROM enroll
    GROUP BY stu_id;
    
  DBMS_OUTPUT.PUT_LINE('Student ID ' || 'Number of courses');
  FOR i IN 1..course_count_table. COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(course_count_table(i).stu_id || '      ' ||  course_count_table(i).num_courses );
  END LOOP;
END;
/

/*
DECLARE
	TYPE course_count_type IS TABLE OF NUMBER
		INDEX BY BINARY_INTEGER;
	course_count_table course_count_type;
BEGIN
	SELECT count(stu_id) BULK COLLECT INTO course_count_table
		FROM enroll
    GROUP BY stu_id;
  FOR i IN 1..course_count_table. COUNT LOOP
    DBMS_OUTPUT.PUT_LINE(course_count_table(i));
  END LOOP;
END;
/
*/