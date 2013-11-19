/*
	The trigger avoids the foreign key error by updating related
	product detail records before updating the BB_DEPARTMENT table.
	
	the trigger fires when an UPDATE of the IDDEPARTMENT column is
	attempted.
*/
CREATE OR REPLACE TRIGGER bb_dept_chg_trg
BEFORE UPDATE OF iddepartment ON bb_department
FOR EACH ROW
BEGIN
	UPDATE bb_product
	SET iddepartment = :NEW.iddepartment
	WHERE iddepartment = :OLD.iddepartment;	
END;
