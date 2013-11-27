/*
	COURSE: ITSE 1345
	AUTHOR: Raul Zuniga
	ASSIGNMENT: Lab 4 part 6
	A trigger TRT_COUNT_TRG for the Treatment table which does the following:
•	Each time an INSERT is made into the Treatment Table, add 1 to the 
  Trt_INS_Count for that Procedure if it exists in the table. If it does 
  not exist in the table, add a row to the table for the procedure setting 
  Trt_INS_Count to 1.
•	Each time a DELETE is made, add 1 to the Trt_DEL_Count for that Procedure 
  if it exists in the table. If it does not exist in the table, add a row to 
  the table for the procedure and set Trt_DEL_Count to 1.
•	Each time an UPDATE occurs for a Trt_Procedure, add 1 to the Trt_UPD_Count.  
  If it is not in the table, add a row to the table for the procedure and set 
  Trt_UPD_Count to 1. If the Column Trt_Procedure is changed, add 1 to the 
  Trt_UPD_Count for the old procedure.
*/
create or replace 
TRIGGER trt_count_trg
  AFTER DELETE OR UPDATE OR INSERT ON treatment
  FOR EACH ROW
DECLARE
  CURSOR stats_cur IS
    SELECT *
    FROM trt_stats
    WHERE trt_procedure = :NEW.trt_procedure;
    
  	TYPE type_stats IS TABLE OF stats_cur%ROWTYPE
    	INDEX BY PLS_INTEGER;
  	trt_stats_table type_stats;
    
    CURSOR stats2_cur IS
    SELECT *
    FROM trt_stats
    WHERE trt_procedure = :OLD.trt_procedure;
    
  	TYPE type_stats2 IS TABLE OF stats2_cur%ROWTYPE
    	INDEX BY PLS_INTEGER;
  	trt_stats2_table type_stats2;
    
    lv_delete_count NUMBER := 0;
BEGIN
IF INSERTING THEN 
  OPEN stats_cur;
  FETCH stats_cur BULK COLLECT INTO trt_stats_table;
  CLOSE stats_cur;
  
  IF trt_stats_table.COUNT = 0 THEN
    INSERT INTO trt_stats
      VALUES(:NEW.trt_procedure, 1, 0, 0);  
  ELSE
    UPDATE trt_stats
    SET trt_ins_count = trt_ins_count + 1
    WHERE trt_procedure = :NEW.trt_procedure;
  END IF;
END IF;
IF UPDATING THEN
  OPEN stats_cur;
  FETCH stats_cur BULK COLLECT INTO trt_stats_table;
  CLOSE stats_cur;
 
  IF trt_stats_table.COUNT = 0 THEN
    INSERT INTO trt_stats
      VALUES(:NEW.trt_procedure, 0, 0, 1);     
  ELSE  
    UPDATE trt_stats
    SET trt_upd_count = trt_upd_count + 1
    WHERE trt_procedure = :NEW.trt_procedure;    
  END IF;
END IF;
IF DELETING THEN
  OPEN stats2_cur;
  FETCH stats2_cur BULK COLLECT INTO trt_stats2_table;
  CLOSE stats2_cur;   
  
  IF trt_stats2_table.COUNT = 0 THEN
    INSERT INTO trt_stats
      VALUES(:OLD.trt_procedure, 0, 1, 0);        
  ELSE  
    UPDATE trt_stats
    SET trt_del_count = trt_del_count + 1
    WHERE trt_procedure = :OLD.trt_procedure;   
  END IF;
END IF;
END;