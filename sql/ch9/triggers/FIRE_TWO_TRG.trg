CREATE OR REPLACE TRIGGER fire_two_trg
	AFTER UPDATE OF deptname ON bb_department
	FOLLOWS fire_one_trg
BEGIN
	DBMS_OUTPUT.PUT_LINE('Trigger TWO fired');
END;