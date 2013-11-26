CREATE OR REPLACE TRIGGER trt_count_trg
AFTER DELETE OR UPDATE OR INSERT ON treatment
FOR EACH ROW
DECLARE
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
BEGIN
    SELECT * BULK COLLECT INTO trt_stats_table
    FROM trt_stats
    WHERE trt_procedure = :NEW.trt_procedure;

  	IF INSERTING THEN 
    	IF SQL%ROWCOUNT = 0 THEN
      		INSERT INTO trt_stats(trt_procedure, trt_ins_count, trt_del_count, trt_upd_count)
        		VALUES(:NEW.trt_procedure, 1, 0, 0);
    	ELSE
      		FOR record IN treatment_cur LOOP
        		UPDATE trt_stats
          		SET trt_ins_count = trt_ins_count + 1
          		WHERE trt_procedure = :NEW.trt_procedure;      
      		END LOOP;
    	END IF;
  	END IF;      
  	IF UPDATING THEN 
    	IF SQL%ROWCOUNT = 0 THEN
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
    	IF SQL%ROWCOUNT = 0 THEN
      		INSERT INTO trt_stats(trt_procedure, trt_ins_count, trt_del_count, trt_upd_count)
        		VALUES(:NEW.trt_procedure, 0, 0, 1);
    	ELSE      
      		FOR record IN treatment_cur LOOP
        		UPDATE trt_stats
          		SET trt_del_count = trt_del_count + 1
          		WHERE trt_procedure = :NEW.trt_procedure;     
      		END LOOP;
    	END IF;
  	END IF;   
END;


	
