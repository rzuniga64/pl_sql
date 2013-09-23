/*  Figure 4-5 A "no data found" error
	NOTE: A SELECT statement embedded in a PL/SQL block's executable 
	section that return no rows results in a 'no data found" error. 
	A common programming mistake is checking the %NOTFOUND cursor attribute
	immediately after a SELECT statement to determine whether rows were selected.
	This technique doesn't work. After the"no data found" error is raised, the 
	remaining statements in the block aren't executed.
*/
DECLARE 
	lv_tot_num bb_basket.total%TYPE;
BEGIN
	--A SELECT statement returning no row results in an error
	SELECT total
		INTO lv_tot_num
		FROM bb_basket
		WHERE idbasket = 99;
	--IF statement not executed
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('Not Found');
	END IF;
END;