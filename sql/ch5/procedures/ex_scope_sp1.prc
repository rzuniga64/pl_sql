CREATE OR REPLACE PROCEDURE EX_SCOPE_SP1
	(p_bsktid IN bb_basketitem.idbasket%TYPE)
AS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Proc1 before call');
	ex_scope_sp2(p_bsktid);
	DBMS_OUTPUT.PUT_LINE('Proc1 after call');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Proc1 exception handler');
END;
/