CREATE OR REPLACE TRIGGER fire_one_trg
	AFTER UPDATE OF deptname ON bb_department
BEGIN
	DBMS_OUTPUT.PUT_LINE('Trigger ONE fired');
END;