/* 	A cursor variable is a pointer to a work area where a query
  	can be processed. An important benefit of cursor variables
	is being able to pass the result sets of queries more
	efficiently.  This method passes the pointer, rather than
	all the data, to the cursor.

	The processing is handled like an explicit cursor. 
	A REFCURSOR type named SYS_REFCURSOR is defined. the
	processing is handled like an explicity cursor by using 	
	OPEN, FETCH, and CLOSE statements.
*/

DECLARE
	cv_prod SYS_REFCURSOR;
	rec_item bb_basketitem%ROWTYPE;
	rec_status bb_basketstatus%ROWTYPE;
	lv_input1_num NUMBER(2) := 3;
	lv_input2_num NUMBER(2) := 4;
BEGIN
	IF lv_input1_num = 3 THEN 
		OPEN cv_prod FOR SELECT * FROM bb_basketitem
			WHERE idbasket = lv_input1_num;
		LOOP
			FETCH cv_prod INTO rec_item;
			EXIT WHEN cv_prod%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(rec_item.idproduct);
		END LOOP;
	END IF;
	IF lv_input2_num = 4 THEN 
		OPEN cv_prod FOR SELECT * FROM bb_basketstatus
			WHERE idbasket = lv_input2_num;
		LOOP
			FETCH cv_prod INTO rec_status;
			EXIT WHEN cv_prod%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(rec_status.idstage || ' - ' || rec_status.dtstage);
		END LOOP;
	END IF;
END;
