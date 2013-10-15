CREATE OR REPLACE FUNCTION memfmt1_sf
	(p_id IN NUMBER,
	p_first IN VARCHAR2,
	p_last IN VARCHAR2)
	RETURN VARCHAR2
	IS
	lv_mem_txt VARCHAR2(35);
BEGIN
	lv_mem_txt := 'Member ' || p_id || ' - ' || p_first || ' ' || p_last;
	RETURN lv_mem_txt;		
END;
