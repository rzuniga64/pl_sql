create or replace 
PACKAGE demo_pkg
IS
	-- declare the REF CURSOR data type in the package specification
	-- declare a parameter with the REF CURSOR type
	TYPE genCur IS ref cursor;
	PROCEDURE return_set
		(p_id IN NUMBER,
		 p_theCursor IN OUT genCur); 
END;
------------------------------------------------------------------------
create or replace 
PACKAGE BODY demo_pkg
AS
PROCEDURE return_set
	(p_id IN NUMBER,
	 p_theCursor IN OUT genCur)
IS
 BEGIN
	-- OPEN statement indicates the query to use for the cursor
	OPEN p_theCursor FOR SELECT * FROM bb_basketitem
		WHERE idbasket = p_id;
 END;
END;