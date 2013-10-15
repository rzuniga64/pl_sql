CREATE OR REPLACE FUNCTION fct_test2_sf
	(p_num IN NUMBER)
		RETURN NUMBER
	IS
	BEGIN
	UPDATE bb_test2
			SET col1 = p_num;
		RETURN p_num;
END;