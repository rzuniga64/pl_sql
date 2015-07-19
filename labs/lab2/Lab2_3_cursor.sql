DECLARE 
  CURSOR cursor_student IS
    SELECT stu_id, count(stu_id) AS num_courses
    FROM enroll
    GROUP BY stu_id;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Student ID ' || 'Number of courses');
  FOR student_record IN cursor_student LOOP
    dbms_output.put_line(student_record.stu_id || '      ' || student_record.num_courses);
  END LOOP;
END;
/