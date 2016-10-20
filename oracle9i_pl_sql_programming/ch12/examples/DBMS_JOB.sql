REM DBMS_JOB.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This script illustrates the DBMS_JOB package.

DROP SEQUENCE temp_seq;

CREATE SEQUENCE temp_seq
  START WITH 1
  INCREMENT BY 1;
  
CREATE OR REPLACE PROCEDURE TempInsert AS
BEGIN
  INSERT INTO temp_table (num_col, char_col)
    VALUES (temp_seq.NEXTVAL,
            TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS'));
  COMMIT;
END TempInsert;
/

VARIABLE v_JobNum NUMBER
BEGIN
  DBMS_JOB.SUBMIT(:v_JobNum, 'TempInsert;', SYSDATE,
                  'SYSDATE + (90/(24*60*60))');
  COMMIT;
END;
/

PRINT v_JobNum

-- This block will remove the job.
BEGIN
  DBMS_JOB.REMOVE(:v_JobNum);
  COMMIT;
END;
/

