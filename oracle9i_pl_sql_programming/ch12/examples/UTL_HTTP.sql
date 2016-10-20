REM UTL_HTTP.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This block demonstrates the UTL_HTTP package. 

set serveroutput on size 200000

DROP TABLE http_results;

CREATE TABLE http_results (
  sequence_no NUMBER PRIMARY KEY,
  piece VARCHAR2(2000));
  
DECLARE
  v_Result UTL_HTTP.HTML_PIECES;
  v_URL VARCHAR2(100) := 'http://www.oracle.com';
  v_Proxy VARCHAR2(100) := 'YOUR_PROXY_SERVER';
BEGIN
  -- This call illustrates the functionality of UTL_HTTP
  -- as of 8.0.6.  It will retreive up to 10 pieces of the
  -- responce, each up to 2000 characters.
  v_Result := UTL_HTTP.REQUEST_PIECES(v_URL, 10, v_Proxy);
  FOR v_Count IN 1..10 LOOP
    INSERT INTO http_results VALUES (v_Count, v_Result(v_Count));
  END LOOP;
END;
/

SELECT * FROM http_results
  ORDER BY sequence_no;
  
  
