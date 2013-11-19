CREATE OR REPLACE TRIGGER BB_DDL_TRG 
AFTER CREATE OR ALTER
ON SCHEMA
BEGIN
	INSERT INTO bb_ddl_log
		SELECT ora_sysevent, ora_dict_obj_owner,
			ora_dict_obj_name, USER, SYSDATE
		FROM DUAL;
END bb_ddl_trg;