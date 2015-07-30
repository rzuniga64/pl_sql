CREATE OR REPLACE
PROCEDURE HOME_STATE_CNT_SP
	(lv_in_state_cnt IN OUT NUMBER,
	 lv_out_state_cnt IN OUT NUMBER)
AS
	CURSOR cursor_student IS
		SELECT lname, fname, mi, home_state 
		FROM student;
BEGIN
	FOR student_record IN cursor_student LOOP
		IF student_record.home_state = 'Tx' THEN
			lv_in_state_cnt := lv_in_state_cnt + 1;
			DBMS_OUTPUT.PUT_LINE(student_record.fname || ' ' || student_record.lname || ' ' || student_record.mi || ' ' || 
								'is in state of Texas');
		ELSE
			lv_out_state_cnt := lv_in_state_cnt + 1;
			DBMS_OUTPUT.PUT_LINE(student_record.fname || ' ' || student_record.lname || ' ' || student_record.mi || ' ' || 
								'is not in state: ' || student_record.home_state);						
		END IF;
	END LOOP;
		DBMS_OUTPUT.PUT_LINE(' ');	
END;
/