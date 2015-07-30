-- A data type declared in a package specification with a TYPE statement 
-- can be referenced by multiple program units.
DECLARE
	-- use the REF CURSOR data type from the package specification
	bask_cur demo_pkg.genCur;
	rec_bask bb_basketitem%ROWTYPE;
BEGIN
	demo_pkg.return_set(3, bask_cur); -- Packaged procedure call
	--Anonymous block using the procedure
	LOOP
		FETCH bask_cur INTO rec_bask;
		EXIT WHEN bask_cur%NOTFOUND;
			DBMS_OUTPUT.PUT_LINE(rec_bask.idproduct);
	END LOOP;
END;
/