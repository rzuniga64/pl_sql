REM dynamicDML.sql
REM Chapter 12, Oracle9i PL/SQL Programming by Scott Urman
REM This procedure demonstrates the DBMS_SQL package.

CREATE OR REPLACE PROCEDURE UpdateClasses(
  /* Uses DBMS_SQL to update the classes table, setting the number of
   * credits for all classes in the specified department to the
   * specified number of credits.
   */
  p_Department  IN classes.department%TYPE,
  p_NewCredits  IN classes.num_credits%TYPE,
  p_RowsUpdated OUT INTEGER) AS

  v_CursorID   INTEGER;
  v_UpdateStmt VARCHAR2(100);
BEGIN
  -- Open the cursor for processing.
  v_CursorID := DBMS_SQL.OPEN_CURSOR;

  -- Determine the SQL string.
  v_UpdateStmt :=
    'UPDATE classes
       SET num_credits = :nc
       WHERE department = :dept';

  -- Parse the statement.
  DBMS_SQL.PARSE(v_CursorID, v_UpdateStmt, DBMS_SQL.NATIVE);

  -- Bind p_NewCredits to the placeholder :nc.  This overloaded
  -- version of BIND_VARIABLE will bind p_NewCredits as a NUMBER,
  -- since that is how it is declared.
  DBMS_SQL.BIND_VARIABLE(v_CursorID, ':nc', p_NewCredits);

  -- Bind p_Department to the placeholder :dept.  This overloaded
  -- version of BIND_VARIABLE will bind p_Department as a CHAR, since
  -- that is how it is declared.
  DBMS_SQL.BIND_VARIABLE_CHAR(v_CursorID, ':dept', p_Department);

  -- Execute the statement.
  p_RowsUpdated := DBMS_SQL.EXECUTE(v_CursorID);

  -- Close the cursor.
  DBMS_SQL.CLOSE_CURSOR(v_CursorID);
EXCEPTION
  WHEN OTHERS THEN
    -- Close the cursor, then raise the error again.
    DBMS_SQL.CLOSE_CURSOR(v_CursorID);
    RAISE;
END UpdateClasses;
/
