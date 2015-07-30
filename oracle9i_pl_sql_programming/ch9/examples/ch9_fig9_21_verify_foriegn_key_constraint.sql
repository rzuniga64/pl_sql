/*
	Try to run the update shown to verify the foreign key constraint error. 
	this error message indicates that prduct detail records assigned to 
	department 2 still exist. 
	After creating the BB_DEPTCHG_TRG trigger this code will work.
*/

UPDATE bb_department
SET iddepartment = 5
WHERE iddepartment = 2;