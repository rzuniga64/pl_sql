CREATE OR REPLACE TRIGGER trt_count_trg
FOR DELETE OR UPDATE OR INSERT ON treatment
COMPOUND TRIGGER
	CURSOR trt_stats_cur IS
    	SELECT *
    	FROM trt_stats
    	WHERE trt_procedure = :NEW.trt_procedure;
    
  	TYPE type_trt_stats IS TABLE OF trt_stats_cur%ROWTYPE
    	INDEX BY PLS_INTEGER;
  	trt_stats_table type_trt_stats;
  
	CURSOR treatment_cur IS
		SELECT *
		FROM treatment
    WHERE pat_nbr = :NEW.pat_nbr;
    
  int NUMBER(2) := 0;
AFTER STATEMENT IS
  BEGIN    
    FOR rec IN trt_stats_cur LOOP
      int := int + 1;
      trt_stats_table(int).trt_procedure := rec.trt_procedure;
      trt_stats_table(int).trt_ins_count := rec.trt_ins_count;
      trt_stats_table(int).trt_del_count := rec.trt_del_count;
      trt_stats_table(int).trt_upd_count := rec.trt_upd_count;
      DBMS_OUTPUT.PUT_LINE('int: ' || int); 
      DBMS_OUTPUT.PUT_LINE('trt_stats_table(int).trt_procedure: ' || trt_stats_table(int).trt_procedure);          
      DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
  END AFTER STATEMENT;
BEFORE EACH ROW IS
  BEGIN 
  	IF INSERTING THEN 
    	IF trt_stats_table.COUNT = 0 THEN
      		INSERT INTO trt_stats(trt_procedure, trt_ins_count, trt_del_count, trt_upd_count)
        		VALUES(:NEW.trt_procedure, 1, 0, 0);
    	ELSIF trt_stats_table.COUNT >= 1 THEN 
      		FOR record IN treatment_cur LOOP
        		UPDATE trt_stats
          		SET trt_ins_count = trt_ins_count + 1
          		WHERE trt_procedure = :NEW.trt_procedure;      
      		END LOOP;
    	END IF;
  	END IF;      
  	IF UPDATING THEN 
    	IF trt_stats_table.COUNT = 0 THEN
      		INSERT INTO trt_stats(trt_procedure, trt_ins_count, trt_del_count, trt_upd_count)
        		VALUES(:NEW.trt_procedure, 0, 0, 1);
    	ELSE    
      		FOR record IN treatment_cur LOOP
        		UPDATE trt_stats
          		SET trt_upd_count = trt_upd_count + 1
          		WHERE trt_procedure = :NEW.trt_procedure;
      		END LOOP;
    	END IF;
  	END IF;
  	IF DELETING THEN 
    	IF trt_stats_table.COUNT = 0 THEN
      		INSERT INTO trt_stats(trt_procedure, trt_ins_count, trt_del_count, trt_upd_count)
        		VALUES(:OLD.trt_procedure, 0, 1, 0);
    	ELSE      
      		FOR record IN treatment_cur LOOP
        		UPDATE trt_stats
          		SET trt_del_count = trt_del_count + 1
          		WHERE trt_procedure = :NEW.trt_procedure;     
      		END LOOP;
    	END IF;
  	END IF;
  END BEFORE EACH ROW;
END;


	
