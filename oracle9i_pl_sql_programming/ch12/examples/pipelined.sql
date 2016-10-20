REM pipelined.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This is an example of a pipelined table function.

DROP TYPE MyType;

CREATE TYPE MyType AS OBJECT (
  field1 NUMBER,
  field2 VARCHAR2(50));
/

DROP TYPE MyTypeList;

CREATE TYPE MyTypeList AS TABLE OF MyType;
/

CREATE OR REPLACE FUNCTION PipelineMe
  RETURN MyTypeList PIPELINED AS
  v_MyType MyType;
BEGIN
  FOR v_Count IN 1..20 LOOP
    v_MyType := MyType(v_Count, 'Row ' || v_Count);
    PIPE ROW(v_MyType);
  END LOOP;
  RETURN;
END PipelineMe;
/

SELECT *
  FROM TABLE(PipelineMe);